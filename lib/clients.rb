def iphone_tokens(publication)
  registered = publication.registered_user_for_publication
  i=0
  tokens = []
  registered.each do |r|
    if r.is_real && r.is_ios
      tokens [i] = r.token
      i=i+1
    end
  end
return tokens
end

def android_tokens(publication)
  registered = publication.registered_user_for_publication
  i=0
  tokens = []
  registered.each do |r|
    if r.is_real && !(r.is_ios)
      tokens [i] = r.token
      i=i+1
    end
  end
return @tokens
end