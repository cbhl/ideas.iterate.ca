$(->
    $idea_textarea = $("#idea-textarea")
    $feedback_list = $("#feedback-list")
    feedback = {
        "grocery": {
            "keywords": ["grocery", "groceries"],
            "message": "The average grocery store has a profit margin of about 1 percent.",
        },
        "mobile": {
            "keywords": ["mobile"],
            "message": "Few users are willing to pay for mobile apps. Think carefully about your revenue streams and how you will pay for rent/food. Ads and the App Store are not enough.",
        },
        "nfc": {
            "keywords": ["nfc"],
            "message": "In practice, NFC is cumbersome, and generally leads to poor user experiences.",
        },
        "rfid": {
            "keywords": ["rfid"],
            "message": "Many consumers are concerned about the privacy implications of RFID tags.",
        },
        "qr": {
            "keywords": ["qr"],
            "message": "In practice, most cell phones have poor cameras (and many lack auto-focus), which makes scanning QR codes difficult. Adoption of QR codes is low outside of Japan and select niche communities.",
        },
        "bitcoin": {
            "keywords": ["bitcoin"],
            "message": "Venture capitalists would rather invest directly in Bitcoins than in Bitcoin-related businesses.",
        },
    }
    feedback_items = {}

    add_feedback_item = (key, {keywords, message}) ->
        $item = $('<li class="feedback-list-item">')
        $item.attr('id', 'feedback-list-item-'+key)
        $item.html('<strong>'+ keywords[0] + '</strong> ' + message)
        $feedback_list.append($item)
        feedback_items[key] = $item

    add_feedback_item key, value for key, value of feedback

    on_idea_input = ->
        idea_text = $idea_textarea.val()
        check_keywords = (keywords) ->
            if idea_text == null
                return false
            return true for keyword in keywords when idea_text.toLowerCase().indexOf(keyword.toLowerCase()) >= 0
            return false
        key_status = {}
        key_status[key] = check_keywords keywords for key, {keywords} of feedback
        visible_item_count = 0
        update_item_visibility = (key, visible) ->
            if visible
                visible_item_count += 1
                feedback_items[key].show()
            else
                feedback_items[key].hide()
        update_item_visibility key, visible for key, visible of key_status
        
        $feedback_list_status = $("#feedback-list-status")
        if not idea_text?.length
            $feedback_list_status.text('Type out your idea, and we will tell you if it is "obviously bad".')
        else if visible_item_count == 0
            $feedback_list_status.text('Your idea does not look "obviously bad" to us. Maybe you should go talk to some potential customers!')
        else if visible_item_count == 1
            $feedback_list_status.text('We found the following potential problem with your idea:')
        else
            $feedback_list_status.text('We found ' + visible_item_count + ' potential problems with your idea:')
        return

    $idea_textarea.on "input propertychange", on_idea_input
    on_idea_input()
)
