class Blog.Models.Post extends Backbone.Model
  paramRoot: 'post'
  defaults:
    title: null
    content: null

class Blog.Collections.PostsCollection extends Backbone.Collection
  model: Blog.Models.Post
  url: '/posts'
  query: ''
  per_page: 5
  page_active: 1
  order: ''
  initialize: (collection, total_entries = 0) ->
    if(isNaN(total_entries))
      @total_entries = 0
    else
      @total_entries = total_entries
  fetch_w_params: (reload) ->
    if(reload) 
      page = 1
    @fetch({ data: { 
                    order: @order,
                    query: @query,
                    per_page: @per_page,
                    page: @page_active
                    } })
  parse: (response) ->
    @total_entries = response.total_entries
    response.results
