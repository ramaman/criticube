class Link < ActiveRecord::Base

  include NewRelic::Agent::Instrumentation::ControllerInstrumentation
  include AutoHtml  
  require 'open-uri'

  has_many  :references,
            :as => :referred,
            :dependent => :destroy

  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'


  def fill_from_url(url_input)

    ## Validate URL
    url_input = url_input.strip
    self.url = url_input
    self.valid?
    if self.errors.messages.has_key?(:url)
      return self.errors.messages    
    else

      ## Check if internal
      if self.internal?  
        return self.internal?  
      
      ## Check if link with same URL already exists
      existing_link = Link.find_by_url(url_input)
      elsif existing_link
        return existing_link

      ## Create new link
      else
        
        
      
      end  
    end    

  end        

  def internal?

    ## Returns internal object if internal, returns nil if not



  end

end
