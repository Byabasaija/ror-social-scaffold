module UserHelper
  def no_pending_requests(requests)
    content_tag :p, 'There are no friend requests.' if requests.empty?
  end
end
