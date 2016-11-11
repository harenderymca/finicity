module Finicity::V1
  module Response
    
    class SaxTesterEmbedded
      include ::Saxomattic
	  attribute :value, :attribute => true
	  attribute :content, :value => true
    end
    
    class Question
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :text
      attribute :answer
      attribute :image
      attribute :choice, :elements => true, :as => :choices
      attribute :imageChoice, :elements => true, :class => ::Finicity::V1::Response::SaxTesterEmbedded
      
    end

    class Mfa
      include ::Saxomattic

      ##
      # Saxomattic Attributes
      #
      attribute :questions, :elements => true, :class => ::Finicity::V1::Response::Question
    end
    
  end
end
