def nl
    "\n"
end

def passo_a_passo (base, expoente)
    puts "\nPasso a passo:"
    parcial = base
    (expoente - 1).times do |i|
        print parcial.to_s
        (expoente - i - 1).times do
            print " * " + base.to_s
        end
        parcial = parcial * base
        puts " = "
    end
    puts parcial
end

print 'Base = '
base = gets.chomp.to_i
print 'Expoente = '
expoente = gets.chomp.to_i

print "#{base}**#{expoente} = ", base**expoente, nl
if expoente > 0
    passo_a_passo(base,expoente)
end
