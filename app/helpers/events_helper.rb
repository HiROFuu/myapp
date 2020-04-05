module EventsHelper
    
    def style_logo(style)
        @styles = style
        if @styles.include?("池坊")
            image_tag "Styles/Ikenobo_logo.png" , size: '75x50'
        elsif @styles.include?("草月流")
            image_tag "Styles/Sogetsuryu_logo.png" , size: '75x50'
        elsif @styles.include?("小原流")
            image_tag "Styles/Ohararyu_logo.png" , size: '75x50'
        end
    end
end
