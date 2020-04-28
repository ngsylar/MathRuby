puts "\nRuby Calculator"
puts "Instructions: enter a numeric expression. Input \"exit\" for exit xD"
puts "Example: \"4*2-(2+2)\" (without the quotes)"
puts ""
print "input = "

# expression = "   4*23- 2+          2*1(1+(57-4))1 / 2     +*++8   "
# expression = "   4*23- 2+          2*((57-4+))1 / 2     +*++8   "
# expression = "   4*23- 2+          2*((57-4))1 / 2     +*++8   "
# expression = "   4*23- 2+          2*((57-4)) / 2     +*++8   "
# expression = "   4*23- 2+          2*((57-4*3)) / 2        "
expression = gets.chomp
if expression.downcase == "exit"
    return
end

temp_array = expression.split       # separa a string por espaços e guarda num array
expression.clear
for array_slice in temp_array
    expression << array_slice       # une os pedaços na string
end
puts expression

delimiters = ['+', '-', '*', '/']
temp_array = expression.split('')   # separa a string por digitos e guarda num array
expression = Array.new
parsing_error = false
last_tk_numbr = false
last_tk_prths = false
qtd_prths = [0,0]

# correção para sinal negativo no inicio da expressao ou após abre parenteses
if temp_array[0] == '-'
    temp_array.insert(0,'0')
end
temp_array.each_with_index do | value, index |
    if value == '(' and temp_array[index+1] == '-'
        temp_array.insert(index+1,'0')
    end
end

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
            qtd_prths[0] += 1
        elsif token == ')'                              # se digito atual é fecha parentesis
            if expression.empty? or !last_tk_numbr      # se digito anterior nao for numero,erro
                parsing_error = true
                break
            end
            expression.push(token)      # recoloca parentesis como elemento individual
            qtd_prths[1] += 1
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

# analise de erros
if qtd_prths[0] != qtd_prths[1]
    puts "\nUnknown parsing error."
elsif parsing_error
    print "\nParsing error. Unexpected token \'"
    print token
    print "\' after: "

    temp_array = String.new
    for temp_token in expression
        temp_array << temp_token
    end
    puts temp_array
else
    for operator in delimiters
        if expression.last == operator
            puts "\nParsing error: expression ending with an operator."
        end
    end
end

# estabelece prioridade de parenteses
prths_priority = [-1]
expression.each_with_index do |token, index|
    if token == '('
        prths_priority.insert(0,index)
    end
end
# p prths_priority

temp_expression = Array.new
for open_prths in prths_priority
    close_prths = open_prths + 1
    while close_prths != expression.length and expression[close_prths] != ')'
        temp_expression.push(expression[close_prths])
        expression.delete_at(close_prths)
    end
    
    step = String.new
    for array_slice in temp_expression
        step << array_slice
    end
    puts step

    temp_expression.each_with_index do |token, index|
        # p token
        case token
        when '*'
            result = temp_expression[index-1].to_i * temp_expression[index+1].to_i
            temp_expression[index-1] = result.to_s
            temp_expression.delete_at(index+1)
            temp_expression.delete_at(index)
            temp_expression.insert(0,'d')
        when '/'
            result = temp_expression[index-1].to_i / temp_expression[index+1].to_i
            temp_expression[index-1] = result.to_s
            temp_expression.delete_at(index+1)
            temp_expression.delete_at(index)
            temp_expression.insert(0,'d')
        end
    end

    # correção do indice do loop (nao sei como voltar para o elemento anterior enquanto dentro do loop)
    if temp_expression[0] == 'd'
        while temp_expression[0] == 'd'
            temp_expression.delete_at(0)
        end
        step = String.new
        for array_slice in temp_expression
            step << array_slice
        end
        puts step
    end

    temp_expression.each_with_index do |token, index|
        case token
        when '+'
            result = temp_expression[index-1].to_i + temp_expression[index+1].to_i
            temp_expression[index-1] = result.to_s
            temp_expression.delete_at(index+1)
            temp_expression.delete_at(index)
            temp_expression.insert(0,'d')
        when '-'
            result = temp_expression[index-1].to_i - temp_expression[index+1].to_i
            temp_expression[index-1] = result.to_s
            temp_expression.delete_at(index+1)
            temp_expression.delete_at(index)
            temp_expression.insert(0,'d')
        end
    end

    # correção do indice do loop (nao sei como voltar para o elemento anterior enquanto dentro do loop)
    if temp_expression[0] == 'd'
        while temp_expression[0] == 'd'
            temp_expression.delete_at(0)
        end
        step = String.new
        for array_slice in temp_expression
            step << array_slice
        end
        puts step
    end

    close_prths = open_prths + 1
    if close_prths != expression.length
        expression[open_prths] = temp_expression[0]
        expression.delete_at(open_prths+1)
    else
        expression[open_prths+1] = temp_expression[0]
    end
    # p expression

    temp_expression.clear
end

print "output = "
puts expression

# ta bom ne...