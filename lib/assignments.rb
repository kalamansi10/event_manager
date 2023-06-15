require 'csv'

def clean_phone_numbers_filter(phone_number)
    pn_arr = phone_number.chars.select {|num| num.to_i.to_s == num.to_s}
    if pn_arr.length < 10 || pn_arr.length > 11
        pn_arr = ["000-000-0000"]
    elsif pn_arr.length == 10
        pn_arr.insert(3, '-').insert(7, '-')
    elsif pn_arr.length == 11
        if pn_arr[0] == 1
            pn_arr.shift!.insert(3, '-').insert(7, '-')
        else
            pn_arr = ["000-000-0000"]
        end
    end
    pn_arr.join
end

def hour_most_people_registered(contents)
    hour_arr = []
    hmpr = []
    contents.each do |row|
        ads = DateTime.strptime(row[:regdate], "%m/%d/%Y %k:%M")
        hour_arr << ads.hour
    end
    hour_arr.uniq.each {|hour| hmpr << "#{hour_arr.count(hour)} people/person registered at #{hour}:00"}
    p hmpr.sort.reverse
end

def day_most_people_registered(contents)
    day_arr = []
    dmpr = []
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    contents.each do |row|
        ads = DateTime.strptime(row[:regdate], "%m/%d/%Y %k:%M")
        day_arr << ads.wday
    end
    day_arr.uniq.each {|day| dmpr << "#{day_arr.count(day)} people/person registered during #{days[day]}s"}
    p dmpr.sort.reverse
end

puts 'Assigments initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)
def clean_phone_numbers(contents)
    contents.each do |row|
        p clean_phone_numbers_filter(row[:homephone])
    end
end

