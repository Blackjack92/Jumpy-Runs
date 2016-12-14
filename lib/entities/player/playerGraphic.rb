require './lib/architecture/graphicalComponent'
require './lib/architecture/position'
require './lib/architecture/rectangle'

class PlayerGraphic < GraphicalComponent

        def initialize(camera, window, player_setting)
        super(camera, window, 32, 32)
        @image = Gosu::Image.load_tiles(@window, './resources/characters.png', width, height, false)
        # Character selection
        @player_setting = player_setting
        set_character_offset
        @frame = @character_offset
    end

    def draw
      position = camera.map_position
      # Check if the x position has changed then the
      # image also should change
      if position.has_changed_in_x?
          @frame = @character_offset + (@frame + 1) % 18
      end

      # Find direction
      if position.direction == :right || position.direction == :left
          @position_direction = position.direction
      end

      # Draw image in left or right direction
      image = @image[@frame]
      if @position_direction == :right
          image.draw rectangle.top_left_x, rectangle.top_left_y, 1, camera.zoom_factor, camera.zoom_factor
      elsif @position_direction == :left
          image.draw rectangle.top_left_x + resized_width, rectangle.top_left_y, 1, -camera.zoom_factor, camera.zoom_factor
      end

      rectangle.draw(@window) if $debug_mode
    end

    private
    def set_character_offset
        # This offset depends on the sprite
        @character_offset = 0 if @player_setting.character == 1
        @character_offset = 23 if @player_setting.character == 2
        @character_offset ||= 46
    end
end