# encoding: utf-8
class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json


  def index
    @recipient_array = User.all.map &:nick

    @messages = Message.order('messages.created_at DESC').includes(:conversations).where('conversations.receiver' => current_user, 'conversations.deleted_by' => [nil, "S"])

  end

  def odeslana_posta
    @recipient_array = User.all.map &:nick
    @messages = Message.order('messages.created_at DESC').includes(:conversations).where('conversations.sender' => current_user, 'conversations.deleted_by' => [nil, "R"])
  end




  # GET /messages/new
  # GET /messages/new.json
  def new
	  typ = (params[:typ])
	  temp = (params[:nick])
    @recipient_array = User.all.map &:nick
    @message = Message.new
	  @message.recipients = temp if temp
	  @message.druh = typ if typ


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  def reply
    @old_msg = Message.find(params[:id])
    @old_msg.body << "<br>--"
    @recipient_array = User.all.map &:nick
    @message = Message.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end


  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.user_id = current_user.id
    @recipient_array = User.all.map &:nick

    respond_to do |format|

      if @message.save
        @message.posli_postu(@message.recipients)
        format.html { redirect_to messages_url(:type => "Dorucena"), :notice => "Posta odoslana" }
        format.json { render json: @message }
      else
        format.html { redirect_to new_message_url, :alert => "Chybne udaje" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end


    end
  end

  def update
    @message = Message.find(params[:id])
    opened = params[:message]
    if opened[:opened] == "true"
      respond_to do |format|
        if @message.procti_spravu(current_user)
          format.json { render :layout => false }
        end
      end
    end
    render nothing: true
  end


  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    postum = Message.find(params[:id])
    conversation = postum.conversations.first
    odoslana = conversation.sender == current_user.id
    prijata = conversation.receiver == current_user.id
    postum.vymaz(current_user.id, odoslana, prijata)

    respond_to do |format|
      format.html { redirect_to messages_url(:type => "Dorucena"), :notice => "Posta bola vymazana" }
      format.js { render :layout => false }
      format.json { head :no_content }
    end
  end

	def trash
		posta = params[:message_ids]
		if posta
			posta.each do |p|
				msg = Message.find(p)
				conversation = msg.conversations.first
				odoslana = conversation.sender == current_user.id
				prijata = conversation.receiver == current_user.id
				msg.vymaz(current_user.id, odoslana, prijata)

			end

			redirect_to messages_url(:type => "Dorucena"), :notice => "Posta bola vymazana"
		else
			redirect_to messages_url(:type => "Dorucena"), :alert => "Vyber postu na vymaz"
		end
	end
end
