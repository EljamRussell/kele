module Roadmap

  # use roadmap_id 31 for testing
  def get_roadmap(roadmap_id)
    response = self.class.get(api_url("/roadmaps/#{roadmap_id}"), headers: { "authorization" => @auth_token })
    @roadmap_data = JSON.parse(response.body)
  end

  #use checkpoint_id 1621 for testing
  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("/checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token })
    @checkpoint_id = JSON.parse(response.body)
  end

end
