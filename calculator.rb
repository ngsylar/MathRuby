puts "Ruby Calculator"
puts "Instructions: enter a numeric expression. Input \"exit\" for exit xD"
puts "Example: \"4*2-(2+2)\" (without the quotes)"
puts ""
print "x = "

expression = "   4*23- 2+          2*57-4 / 70         "
# expression = gets.chomp
# if expression.downcase == "exit"
#     return
# end

temp_array = expression.split
expression.clear
for array_slice in temp_array
    expression << array_slice
end

delimiters = [' ', '+', '-', '*', '/']
temp_array = expression.split('')
expression = Array.new
exp_last_number = false
p temp_array
for token in temp_array
    op_flag = false
    for operator in delimiters
        if token == operator
            op_flag = true
            exp_last_number = false
            break
        end
    end
    
    if !op_flag
        if exp_last_number
            expression.last << token
        else
            expression.push(token)
            exp_last_number = true
        end
    elsif expression.empty?
        p "error"
    else
        expression.push(token)
        exp_last_number = false
    end
end
p expression