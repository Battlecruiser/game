# encoding: utf-8
class AdminController < ApplicationController
  authorize_resource :class => false # CanCan
  check_authorization # CanCan

  def prepni_povoleni_prihlasovani
    login = Aplikace.prihlaseni_povoleno?

    if login
      Global.prepni('login', 1, false)
    else
      Global.prepni('login', 1, true)
    end
    redirect_to :back
  end

  def prepni_povoleni_zakladani
    signup = Aplikace.zakladani_hracu_povoleno?

    if signup
      Global.prepni('signup', 1, false)
    else
      Global.prepni('signup', 1, true)
    end
    redirect_to :back
  end

  def zamkni_hru
    Aplikace.zamkni_hru
    redirect_to :back
  end

  def kompletni_prepocet
    Prepocet.kompletni_prepocet
    redirect_to :back
  end

  def prepocti_vliv
    Prepocet.prepocti_vliv
    redirect_to :back
  end

  def pridej_suroviny
    if params[:commit] == "Proved"
      case params[:komu]
        when "hraci"
          user = User.find(params[:user_id_suroviny])
          user.update_attributes(
              :solar => user.solar + params[:solary_user].to_f,
              :melange => user.melange + params[:melange_user].to_f,
              :exp => user.exp + params[:expy_user].to_f
          )
          user.domovske_leno.resource.update_attributes(
              :material => user.domovske_leno.resource.material + params[:material_user].to_f
          )
          redirect_to user
        when "rodu"
          house = House.find(params[:house_id_suroviny])
          house.update_attributes(
              :solar => house.solar + params[:solary_narod].to_f,
              :melange => house.melange + params[:melange_narod].to_f,
              :material => house.material + params[:material_narod].to_f,
              :exp => house.exp + params[:expy_narod].to_f
          )
          redirect_to house
      end
    else

    end
  end

  def udalosti_admin
    @events = Environment.order(:started_at).all
    @influence = Influence.order(:started_at).all

  end

  def update_udalost
    @event = Environment.find(params[:id])
    if params[:commit] == "Save"
      @event.update_attributes(params[:environment])
      redirect_to udalosti_path
    else

    end
  end

  def leno_update_udalost
    @effect = Influence.find(params[:id])
    if params[:commit] == "Save"
      @event.update_attributes(params[:effect])
      redirect_to udalosti_path
    else

    end
  end

  def global_index
    @globals = Global.order(:setting).all
  end

  def update_global
    @global = Global.find(params[:id])
    if params[:commit] == "Save"
      @global.update_attributes(params[:global])

      redirect_to global_index_path
    else

    end
  end

  def sweep_session
    Session.sweep(params[:hodin].to_i.hour)
    redirect_to :back
  end

  def wipe
    Aplikace.wipe
    redirect_to :back
  end

  def rozpust_landsraad
    Landsraad.rozpustit
    redirect_to :back
  end

  def odvolat_imperatora
    Imperium.odvolej_imperatora
    redirect_to :back
  end

end