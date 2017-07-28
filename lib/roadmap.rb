module Roadmap
  def get_roadmap(roadmap_id)
    url = "#{@endpoint}/roadmaps/#{roadmap_id}"

    response = Kele.get(url, headers: { "authorization" => @auth_token })
  end

  def get_checkpoint(checkpoint_id)
    url = "#{@endpoint}/checkpoints/#{checkpoint_id}"

    response = Kele.get(url, headers: { "authorization" => @auth_token })
  end
end
