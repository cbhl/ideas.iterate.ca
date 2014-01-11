$(->
    $idea_textarea = $("#idea-textarea")
    $feedback_list = $("#feedback-list")
    feedback = {
        "grocery": {
            "keywords": ["grocery"],
            "message": "The average grocery store has a profit margin of about 1 percent.",
        },
    }
    add_feedback_item = (key, {keywords, message}) =>
        $item = $('<li class="feedback-list-item">')
        $item.attr('id', 'feedback-list-item-'+key)
        $item.html('<strong>'+ key + '</strong> ' + message)
        $feedback_list.append($item)
        $idea_textarea.on "input propertychange", (e) =>
            idea_text = $idea_textarea.val()
            # TODO(cbhl): handle multiple keywords
            if idea_text.indexOf(keywords[0]) >= 0
                $item.show()
            else
                $item.hide()

    add_feedback_item key, value for key, value of feedback

)
