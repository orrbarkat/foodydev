def token_array(publication)
  @registered = publication.registered_user_for_publication
  i=0
  @tokens = []
  @registered.each do |r|
    if r.is_real
      @tokens [i] = r.token
      i=i+1
    end
  end
return @tokens
end