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

temp_array = expression.split       # separa a string por espaços e guarda num array
expression.clear
for array_slice in temp_array
    expression << array_slice       # une os pedaços na string
end

delimiters = [' ', '+', '-', '*', '/']
temp_array = expression.split('')   # separa a string por digitos e guarda num array
expression = Array.new
exp_last_number = false
p temp_array

for token in temp_array                 # para cada digito da expressao
    op_flag = false
    for operator in delimiters
        if token == operator            # compara digito com cada operador
            op_flag = true
            exp_last_number = false
            break
        end
    end
    
    if !op_flag                         # se digito nao é operador
        if exp_last_number              # se ultimo digito é numero
            expression.last << token    # junta numero atual ao anterior
        else                            # se ultimo digito é operador
            expression.push(token)      # recoloca numero na expressao como elemento distinto do anterior
            exp_last_number = true
        end
    elsif expression.empty?             # se primeiro digito da expressao é um operador, erro
        p "error"
    else                                # se digito é operador 
        expression.push(token)          # recoloca na expressao como elemento distinto
        exp_last_number = false
    end
end
p expression