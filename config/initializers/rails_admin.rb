RailsAdmin.config do |config|

  config.main_app_name = ["Representantes", "Comerciais"]

  config.navigation_static_links = {
    'Desenvolvedor' => 'http://facebook.com/arlymoura'
  }

  config.navigation_static_label = "Lins Úteis"

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true


  config.model User do

    create do
      field :name
      field :document
      field :email

      field :notes

      field :addresses

      field :password, :hidden do
        default_value do
          Devise.friendly_token.first(6)
        end
      end

      field :manager_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end

      field :kind, :hidden do
        default_value do
          :salesman
        end
      end

      field :status, :hidden do
        default_value do
          :active
        end
      end

    end
  end

  config.model Sale do
    create do
      field  :sale_date
      field  :discount
      field  :notes
      field  :product_quantities

      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end

    edit do
      field  :sale_date
      field  :discount
      field  :notes
      field  :product_quantities

      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end

  config.model Product do
    list do
      field  :name
      field  :photo
      field  :status
      field  :price
      field  :created_at do
        strftime_format "%d/%m/%Y"
      end
    end

    edit do
      field  :name
      field  :photo
      field  :status
      field  :price
    end

    create do
      field  :name
      field  :photo
      field  :status
      field  :price
    end

    show do
      field  :name
      field  :photo
      field  :status
      field  :price
      field  :created_at
      field  :updated_at
    end

  end

  config.model Discount do
    parent Product
  end

  config.model Sale do
    parent User
    weight -2
  end

  config.model Comission do
    parent User
    weight -1
  end

  config.model ProductQuantity do
    visible false
  end

  config.model Address do
    visible false
  end


  config.model ProductQuantity do
    visible false
  end

  config.model Address do
    visible false
  end

  config.model ProductQuantity do
    edit do
      field :product
      field :quantity

      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end


  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
