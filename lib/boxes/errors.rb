module Boxes
  # A collection of errors which can be raised by boxes.
  module Errors
    # Base error class for all other errors.
    class BoxesError < StandardError; end

    # Raised when a template is missing.
    class TemplateNotFoundError < BoxesError; end

    # Raised when a script is missing.
    class ScriptNotFoundError < BoxesError; end

    # Raised when an expected argument is missing.
    class MissingArgumentError < BoxesError; end
  end
end
