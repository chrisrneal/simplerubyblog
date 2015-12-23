module ApplicationHelper
    ## Returns a url for gravitar utilizing the MD5 hash of the user's email address.
    ## Use this result as the image_src
    def gravitar_for(user, size=80)
        hash = Digest::MD5.hexdigest(user.email.downcase)
        return "http://www.gravatar.com/avatar/#{hash}?s=#{size}"
    end
end
