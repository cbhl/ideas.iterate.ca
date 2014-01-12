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
        "location": {
            "keywords": ["location", "gps"],
            "message": "Many consumers are concerned about the privacy implications of location-aware apps. Also, make sure your app doesn't replicate functionality in Google+, Moves, Path, Foursquare, or Find My Friends (iPhone).",
        },
        "local": {
            "keywords": ["local", "near you"],
            "message": "Building a comprehensive database of 'local' destinations is difficult. Relying on a third-party database presents a business risk if (e.g. Google Maps, FourSquare) decides to shut down and/or monetize their API.",
        },
        "social": {
            "keywords": ["social", "share"],
            "message": "Facebook has made changes to their platform which make it very difficult to replicate the success of companies like Zynga, Twitter, or Path through organic growth.",
        },
        "meet-up": {
            "keywords": ["meet up"],
            "message": "Meeting up with friends is not an excruciating problem. There are too many free existing alternatives (e.g. directly asking people where they are over SMS/Facebook Messenger/Google Hangouts/iMessage) for anyone to want to pay for an app that solves this.",
        },
        "meal-tracking": {
            "keywords": ["meal tracking", "food you eat", "diet", "nutrition"],
            "message": "Users usually will not remember to enter their meals into your application, and/or find it tedious. This makes it difficult to keep users engaged.",
        },
        "athlete": {
            "keywords": ["athlete"],
            "message": "Technology for use by athletes is patented to death."
        },
        "tea-coffee": {
            "keywords": ["tea", "coffee"],
            "message": "Is your name Robert Elder?",
        },
        "parenting": {
            "keywords": ["parent/child", "parent", "parenting", "child", "children", "son", "daughter"],
            "message": "The collection of personal information from children under 13 years of age is restricted by The Children's Online Privacy Protection Act of 1998. Parents often will buy 'nice to have' things for their children, only to drop off or disengage within the first week. Make sure that you are solving an excruciating pain point.",
        },
        "3d-printing": {
            "keywords": ["3D printing", "3D printed"],
            "message": '<a href="http://xkcd.com/924/">http://xkcd.com/924/</a>',
        },
        "machine-learning": {
            "keywords": ["machine learning", "suggestion", "auto-suggest", "recommend"],
            "message": "Automatic recommendation systems require a large corpus of existing (usually labelled) data. Obtaining this data usually poses an unsolvable chicken-and-egg problem for startups."
        },
        "edu": {
            "keywords": ["education", "edu", "school", "schools", "educators", "teachers", "university", "college"],
            "message": "There is a large amount of process (bureaucracy) around obtaining software for use in public education. Requests for Proposals (RFPs) often mandate choosing a lowest-cost solution, and often require significant sales work.",
        },
        "video": {
            "keywords": ["video", "tv", "television", "movie", "movies"],
            "message": "Obtaining licenses to use video content (and/or enforcing copyright in user-generated videos) is usually very difficult and/or expensive.",
        },
        "music": {
            "keywords": ["music", "karaoke"],
            "message": "Obtaining licenses to use popular music is usually very difficult and/or expensive.",
        },
        "medical": {
            "keywords": ["medicine", "medical", "hospital", "doctor", "doctors", "sick", "cold", "flu"],
            "message": "There is lots of red tape and legislation. For example, in Ontario, health records may not be transmitted on the U.S. Internet. Most existing providers in Ontario send medical records exclusively over fax machines to deal with these restrictions.",
        },
        "hardware": {
            "keywords": ["hardware"],
            "message": "High capital costs. Long turnaround to get prototypes from manufacturers in China.",
        },
        "platform": {
            "keywords": ["marketplace/platform", "platform", "marketplace"],
            "message": "It is difficult to produce enough content on your site to bootstrap past the chicken-and-egg problem of not having users on both sides of your marketplace at the same time.",
        },
        "clothing": {
            "keywords": ["clothing"],
            "message": "Clothing exchanges are very common, but users usually will not pay for them. Recognizing an item of clothing from an image is very difficult technically, if not impossible."
        },
        "todo": {
            "keywords": ["to-do", "to do", "todo", "reminder"],
            "message": '<a href="http://xkcd.com/927/">http://xkcd.com/927/</a>',
        },
        "note-taking": {
            "keywords": ["note-taking", "note", "notes"],
            "message": '<a href="http://xkcd.com/927/">http://xkcd.com/927/</a>',
        },
        "calendar": {
            "keywords": ["calendar", "schedule", "scheduling", "iCal", "google calendar", "alarm", "clock"],
            "message": "There are many arcane edge cases when handling dates and times. For example, try executing <pre>cal 9 1752</pre> on a Unix/Linux system. Also, DST and time zones.",
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
            # check if the user has entered more than 3 words:
            idea_text = idea_text.trim().replace(/\s+/g, " ");    #remove extra spaces
            if idea_text.split(" ").length > 3
                $feedback_list_status.text('Your idea does not look "obviously bad" to us. Maybe you should go talk to some potential customers!')
            else 
                $feedback_list_status.text('Please use more than three words to describe your idea, and we will tell you if it is "obviously bad".')
        else if visible_item_count == 1
            $feedback_list_status.text('We found the following potential problem with your idea:')
        else
            $feedback_list_status.text('We found ' + visible_item_count + ' potential problems with your idea:')
        return

    $idea_textarea.on "input propertychange", on_idea_input
    on_idea_input()
)
