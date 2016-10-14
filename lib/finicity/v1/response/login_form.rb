module Finicity::V1
  module Response
    class LoginField
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :id
      attribute :name
      attribute :description
      attribute :value
      attribute :displayOrder, :type => ::Integer, :as => :display_order
      attribute :mask
      attribute :instructions
      attribute :valueLengthMin, :type => ::Integer, :as => :value_length_min
      attribute :valueLengthMax, :type => ::Integer, :as => :value_length_max
      

      def mask?
        mask == 'true'
      end
    end

    class LoginForm
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :loginField, :elements => true, :class => ::Finicity::V1::Response::LoginField, :as => :login_fields
    end
  end
end
