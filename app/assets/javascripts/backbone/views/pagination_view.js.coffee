class Blog.Views.PaginatedView extends Backbone.View

  template: JST["backbone/templates/pagination"]

  events:
    "click #pages a" : "change_page"
    "click #per_pages a" : "change_quantity"
    "click .next a" : "next_page"
    "click .previus a" : "previus_page"

  el: '#pagination'

  page_show: 6

  initialize: (params) ->
    @collection.on('reset', @render, @)
    @render()

  render: (eventName) -> 
    @page_show = 6
    @page_count = Math.ceil(@collection.total_entries / @collection.per_page)
    if (@page_count <= @page_show) 
      @page_show = @page_count

    @page_active = @collection.page_active
    
    range = Math.floor(@page_show / 2)
    nav_begin = @page_active - range
    if (@page_show % 2 == 0)  
      nav_begin++
    nav_end = @page_active + range
    left_dots = true
    right_dots = true
    if(nav_begin <= 2) 
      nav_end = @page_show
      if (nav_begin == 2) 
        nav_end++
      nav_begin = 1
      left_dots = false
            
    if(nav_end >= @page_count - 1 ) 
      #nav_begin = @page_count - @page_show + 1
      if (nav_end == @page_count - 1) 
        nav_begin--
      nav_end = @page_count
      right_dots = false    

    @$el.html(@template({ 
      link: @link, 
      page_count: @page_count, 
      page_active: @page_active,
      nav_begin: nav_begin,
      nav_end: nav_end,
      left_dots: left_dots,
      right_dots: right_dots
      per_page: @collection.per_page
      }))
    
  change_page: (e) ->
    e.preventDefault()
    page = $(e.target).text()
    @collection.page_active = page
    @collection.fetch_w_params(false)

  change_quantity: (e) ->
    e.preventDefault()
    @collection.per_page = $(e.target).text()
    @collection.page_active = 1
    @collection.fetch_w_params(true)

  next_page: (e) ->
    e.preventDefault()
    page = @collection.page_active + 1
    if (page > @page_count) 
      page = @page_count
    @collection.page_active = page
    @collection.fetch_w_params(false)

  previus_page: (e) ->  
    e.preventDefault()
    page = @collection.page_active - 1
    if (page < 1) 
      page = 1
    @collection.page_active = page
    @collection.fetch_w_params(false)
