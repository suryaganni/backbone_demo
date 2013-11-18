Blog.Views.Posts ||= {}

class Blog.Views.Posts.PostView extends Backbone.View
  template: JST["backbone/templates/posts/post"]
  events:
    "click .destroy" : "destroy"
    "click .content, .title" : "in_edit"
    "keypress .in_edit" : "save_edit"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  in_edit: (e) ->
    target = $(e.target)
    text = target.text()
    t_class = 'input_' + target.attr('class')
    console.log(t_class)
    input = $("<input>", { class: 'in_edit ' + t_class }).val(text)
    target.parent('td').html( input )
    return false

  save_edit: (e) ->
    if(e.keyCode == 13)
      target = $(e.target)
      console.log(target)
      text = target.val()
      if(target.hasClass('input_title'))
        @model.save({ title: text })
      if(target.hasClass('input_content'))
        @model.save({ content: text })
      link = $('<a>', { class: 'name', href: '#' }).text(text)
      target.parent('td').html( link )
      return false    

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
