class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities



    user ||= User.new # guest user (not logged in)

    if user
      if user.admin?
	      can :access, :rails_admin   # grant access to rails_admin
	      can :dashboard              # grant access to the dashboard
        can :manage, :all
      else
	      #cannot :access, :rails_admin   # grant access to rails_admin
	      #cannot :dashboard              # grant access to the dashboard
        cannot [:update, :delete], Global
        cannot [:delete, :update], Message
        cannot [:delete], Conversation
        cannot [:read, :update, :create, :delete], Product
        can [:read, :update], User
        can [:zmena_hesla, :zmena_hesla_f], User
        can [:read, :create], Subhouse
        #can [:update], User, :id => user.id
        can [:read, :osidlit_pole, :zobraz_arrakis], Planet
        can [:read], House
        can [:read, :update, :prejmenuj_pole, :postavit_budovu, :presun_suroviny, :vylepsi_budovu], Field, :user_id => user.id
        can [:read, :update], Resource
        can [:read, :create], Vote
        cannot [:update, :delete], Operation
        can [:read], Operation, :user_id => user.id
        can [:read], Operation, :house_id => user.house.id
        can [:update], Vote, :elector => user.id
        can [:zobraz_eod], Eod, :user_id => user.id
        can [:show], Imperium
        can [:show], Landsraad
        can [:read], Law
        can [:read], Poll

        if user.emperor?
          can [:sprava, :posli_imperialni_suroviny], Imperium
          can [:create], Law
          can [:create, :edit], Poll
          can [:jednani], Landsraad
        end
        if user.regent?
          can [:sprava, :posli_imperialni_suroviny], Imperium
        end
        if user.leader?
          can [:kolonizuj, :sprava_rod], House do |house|
            user.try(:house) == house
          end
          #:id => user.house_id
          can [:pridel_pravo, :odeber_pravo], User do |hrac|
            hrac.house == user.house
          end
          #can [:u_ziadost], User
          can [:create], Law
          can [:jednani], Landsraad
        end
        if user.army_mentat?
          can [:sprava_rod], House, :id => user.house_id
        end
        if user.mentat?
          can [:kolonizuj, :sprava_rod, :posli_rodove_suroviny], House, :id => user.house_id
        end
        if user.diplomat?
        end
        if user.general?
          can [:vyhod_mr, :prijmi_hrace_mr, :posli_mr_sur, :menuj_vice], Subhouse, :id => user.subhouse_id
        end
        if user.vicegeneral?
          can [:prijmi_hrace_mr, :posli_mr_sur], Subhouse, :id => user.subhouse_id
        end
        if user.arrakis?
          can [:postavit_arrakis], Field
        end
        if user.landsraad?
          can [:create], Law
          can [:create, :edit], Poll
          can [:jednani], Landsraad
        end
        if user.court?
        end
        if user.vezir?
          can [:sprava, :posli_imperialni_suroviny], Imperium
        end
        if user.general?
          can [:read, :update, :sprava_mr], Subhouse
        end
        if user.vicegeneral?
          can [:read, :update, :sprava_mr], Subhouse
        end
      end
    else

    end
  end
end
