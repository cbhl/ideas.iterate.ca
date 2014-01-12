$(->
    $idea_textarea = $("#idea-textarea")
    $feedback_list = $("#feedback-list")
    feedback = {
        "grocery": {
            "keywords": ["grocery"],
            "message": "The average grocery store has a profit margin of about 1 percent.",
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

    $idea_textarea.on "input propertychange", (e) ->
        idea_text = $idea_textarea.val()
        check_keywords = (keywords) ->
            return true for keyword in keywords when idea_text.indexOf(keyword) >= 0
            return false
        key_status = {}
        key_status[key] = check_keywords keywords for key, {keywords} of feedback
        update_item_visibility = (key, visible) ->
            if visible
                feedback_items[key].show()
            else
                feedback_items[key].hide()
        update_item_visibility key, visible for key, visible of key_status
        return
)
