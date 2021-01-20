# frozen_string_literal: true

class PostsReflex < ApplicationReflex
  include CableReady::Broadcaster
  include ActionView::RecordIdentifier
  # Add Reflex methods in this file.
  #
  # All Reflex instances include CableReady::Broadcaster and expose the following properties:
  #
  #   - connection  - the ActionCable connection
  #   - channel     - the ActionCable channel
  #   - request     - an ActionDispatch::Request proxy for the socket connection
  #   - session     - the ActionDispatch::Session store for the current visitor
  #   - flash       - the ActionDispatch::Flash::FlashHash for the current request
  #   - url         - the URL of the page that triggered the reflex
  #   - params      - parameters from the element's closest form (if any)
  #   - element     - a Hash like object that represents the HTML element that triggered the reflex
  #     - signed    - use a signed Global ID to map dataset attribute to a model eg. element.signed[:foo]
  #     - unsigned  - use an unsigned Global ID to map dataset attribute to a model  eg. element.unsigned[:foo]
  #   - cable_ready - a special cable_ready that can broadcast to the current visitor (no brackets needed)
  #   - reflex_id   - a UUIDv4 that uniquely identies each Reflex
  #
  # Example:
  #
  #   before_reflex do
  #     # throw :abort # this will prevent the Reflex from continuing
  #     # learn more about callbacks at https://docs.stimulusreflex.com/lifecycle
  #   end
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com/reflexes#reflex-classes

  def repost
    @post = Post.find(element.dataset[:id])
    @post.increment! :repost_count

    cable_ready["feed"].text_content(
      selector: "##{dom_id(@post, "reposts")}", # eg: id="reposts_post_2"
      text: @post.repost_count
    )

    # emit broadcast with cable ready
    cable_ready.broadcast
  end

  def like
    @post = Post.find(element.dataset[:id])
    @post.increment! :likes_count

    cable_ready["feed"].text_content(
      selector: "##{dom_id(@post, "likes")}", # eg: id="reposts_post_2"
      text: @post.likes_count
    )

    # emit broadcast with cable ready
    cable_ready.broadcast
  end
  
end
