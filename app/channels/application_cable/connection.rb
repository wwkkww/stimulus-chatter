module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :session_id

    # restrict web socket communication to user session
    def connect
      self.session_id = request.session.id
    end
  end
end
