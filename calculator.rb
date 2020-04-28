puts "Ruby Calculator"
puts "Instructions: enter a numeric expression. Input \"exit\" for exit xD"
puts "Example: \"4*2-(2+2)\" (without the quotes)"
puts ""
print "x = "

# expression = "   4*23- 2+          2*1(1+(57-4))1 / 2     +*++8   "
# expression = "   4*23- 2+          2*((57-4+))1 / 2     +*++8   "
# expression = "   4*23- 2+          2*((57-4))1 / 2     +*++8   "
# expression = "   4*23- 2+          2*((57-4)) / 2     +*++8   "
expression = "   4*23- 2+          2*((57-4)) / 2        "
# expression = gets.chomp
# if expression.downcase == "exit"
#     return
# end

temp_array = expression.split       # separa a string por espaços e guarda num array
expression.clear
for array_slice in temp_array
    expression << array_slice       # une os pedaços na string
end

puts expression
delimiters = ['+', '-', '*', '/']
temp_array = expression.split('')   # separa a string por digitos e guarda num array
expression = Array.new
last_tk_numbr = false
last_tk_prths = false
parsing_error = false

for token in temp_array                 # para cada digito da expressao
    op_flag = false
    for operator in delimiters
        if token == operator            # compara digito atual com cada operador
            op_flag = true
            last_tk_prths = false
            break
        end
    end
    
    if !op_flag                         # se digito atual nao é operador
        if token == '('                 # se digito atual é abre parentesis
            if last_tk_numbr            # se digito anterior for numero, erro
                parsing_error = true
                break
            end
            expression.push(token)      # recoloca parentesis como elemento individual
        elsif token == ')'                              # se digito atual é fecha parentesis
            if expression.empty? or !last_tk_numbr      # se digito anterior nao for numero,erro
                parsing_error = true
                break
            end
            expression.push(token)      # recoloca parentesis como elemento individual
            last_tk_prths = true

        elsif last_tk_numbr             # se digito atual é numero
            if last_tk_prths            # se digito anterior é fecha parentesis, erro
                parsing_error = true
                break
            end                         # se digito anterior é numero
            expression.last << token    # junta numero atual ao anterior
        else                            # se digito anterior é operador
            expression.push(token)      # recoloca numero na expressao como elemento distinto do anterior
            last_tk_numbr = true
        end

    # se primeiro digito da expressao é um operador ou se ambos digito atual e anterior são operadores, erro
    elsif expression.empty? or !last_tk_numbr
        parsing_error = true
        break

    else                                # se digito atual é operador 
        expression.push(token)          # recoloca na expressao como elemento distinto
        last_tk_numbr = false
    end
end
# p expression

if parsing_error
    print "\nParsing error. Unexpected token \'"
    print token
    print "\' after: "

    temp_array = String.new
    for temp_token in expression
        temp_array << temp_token
    end
    puts temp_array
end