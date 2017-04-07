module RC
  def self.json_request_only
    {
      defaults:    { format: :json }, 
      constraints: { format: :json }
    }
  end
  
  def self.ajax_server
    {
      constraints: lambda { |request| request.xhr? },
      only: [:create, :destroy]
    }
  end
  
  def self.non_restful
    {
      only: []
    }
  end
end