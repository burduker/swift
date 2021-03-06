filter = {}
inc = @opts[:include]  
filter['news_rubric.slug'] = inc.to_s.split /\W+/                  if inc
filter['news_rubric.slug.not'] = @opts[:exclude].to_s.split /\W+/  if @opts[:exclude]
filter[:offset] = @opts[:rubric].to_i                              if @opts[:rubric]
case @opts[:type]
when :period
  filter[:limit] = @opts[:count].to_i                                 
  filter[:date] = Date.today.to_date..(Date.today.to_date + @opts[:count].to_i )                                      
  filter[:order] = :date.asc                                         
  @events = NewsEvent.published.all( filter )
when :nearest
  filter[:limit] = @opts[:count].to_i                                 
  filter[:order] = :date.asc  
  filter[:date.gte] = Date.today                   
  @events = NewsEvent.published.all(filter)
end
