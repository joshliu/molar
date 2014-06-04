require 'sinatra'

MASSES = {
  "H" => 1.008,
  "He" => 4.0026,
  "Li" => 6.94,
  "Be" => 9.01218,
  "B" => 10.81,
  "C" => 12.011,
  "N" => 14.007,
  "O" => 15.999,
  "F" => 18.9984,
  "Ne" => 20.1797,
  "Na" => 22.9898,
  "Mg" => 24.305,
  "Al" => 26.9815,
  "Si" => 28.085,
  "P" => 30.9738,
  "S" => 32.06,
  "Cl" => 35.45,
  "Ar" => 39.948,
  "K" => 39.0983,
  "Ca" => 40.078,
  "Sc" => 44.9559,
  "Ti" => 47.867,
  "V" => 50.9415,
  "Cr" => 51.9961,
  "Mn" => 54.938,
  "Fe" => 55.845,
  "Co" => 58.9332,
  "Ni" => 58.6934,
  "Cu" => 63.546,
  "Zn" => 65.38,
  "Ga" => 69.723,
  "Ge" => 72.63,
  "As" => 74.9216,
  "Se" => 78.971,
  "Br" => 79.904,
  "Kr" => 83.798,
  "Rb" => 85.4678,
  "Sr" => 87.62,
  "Y" => 88.9058,
  "Zr" => 91.224,
  "Nb" => 92.9064,
  "Mo" => 95.95,
  "Tc" => 97.0,
  "Ru" => 101.07,
  "Rh" => 102.906,
  "Pd" => 106.42,
  "Ag" => 107.868,
  "Cd" => 112.414,
  "In" => 114.818,
  "Sn" => 118.71,
  "Sb" => 121.76,
  "Te" => 127.6,
  "I" => 126.904,
  "Xe" => 131.293,
  "Cs" => 132.905,
  "Ba" => 137.327,
  "La" => 138.905,
  "Ce" => 140.116,
  "Pr" => 140.908,
  "Nd" => 144.242,
  "Pm" => 145.0,
  "Sm" => 150.36,
  "Eu" => 151.964,
  "Gd" => 157.25,
  "Tb" => 158.925,
  "Dy" => 162.5,
  "Ho" => 164.93,
  "Er" => 167.259,
  "Tm" => 168.934,
  "Yb" => 173.054,
  "Lu" => 174.967,
  "Hf" => 178.49,
  "Ta" => 180.948,
  "W" => 183.84,
  "Re" => 186.207,
  "Os" => 190.23,
  "Ir" => 192.217,
  "Pt" => 195.084,
  "Au" => 196.967,
  "Hg" => 200.592,
  "Tl" => 204.38,
  "Pb" => 207.2,
  "Bi" => 208.98,
  "Po" => 209.0,
  "At" => 210.0,
  "Rn" => 222.0,
  "Fr" => 223.0,
  "Ra" => 226.0,
  "Ac" => 227.0,
  "Th" => 232.038,
  "Pa" => 231.036,
  "U" => 238.029,
  "Np" => 237.0,
  "Pu" => 244.0,
  "Am" => 243.0,
  "Cm" => 247.0,
  "Bk" => 247.0,
  "Cf" => 251.0,
  "Es" => 252.0,
  "Fm" => 257.0,
  "Md" => 258.0,
  "No" => 259.0,
  "Lr" => 262.0,
  "Rf" => 267.0,
  "Db" => 270.0,
  "Sg" => 271.0,
  "Bh" => 270.0,
  "Hs" => 277.0,
  "Mt" => 276.0,
  "Ds" => 281.0,
  "Rg" => 282.0,
  "Cn" => 285.0,
  "Uut" => 285.0,
  "Fl" => 289.0,
  "Uup" => 2889.0,
  "Lv" => 293.0,
  "Uus" => 294.0,
  "Uuo" => 294.0
}

class String
  def is_upper?
    self == self.upcase && self != self.downcase
  end

  def is_lower?
    self == self.downcase && self != self.upcase
  end

  def is_element?
  	if MASSES[self] != nil
  		return true
  	else
  		return false
  	end
  end
end

class Array
	def contains_only(some_class)
		contains = true
		self.each do |x|
			if x.class == some_class
				next
			else
				contains = false
			end
		end
		return contains
	end

	def format
		self.each_with_index do |x,i|
			if x.class == Fixnum
				if self[i-1] != ")"
					self[i-1] = self[i-1]*x
					self.delete_at(i)
				else
					next
				end
			elsif x == "("
				self.each_with_index do |x2,i2|
					if x2 == ")"
						m = self[i+1...i2].format
						self.insert(i,m)
						(i2+1-i).times {self.delete_at(i+1)}
						return self
					end
				end
			end
		end
		if self.contains_only(Float)
			return self.reduce(:+)
		else
			self.format
		end
	end

end

def molar_mass(compound)

	formatted = []

	compound = compound.split("")

	compound.each_with_index do |x,i|
		if compound.length == 1
			if x.is_element?
				return MASSES[x]
			else
				return "wat"
			end
		else
			if x.is_lower?
				next
			elsif x.is_upper?
				if compound[i+1] != nil
					if compound[i+1].is_lower?
						formatted << compound[i..i+1].join
					else
						formatted << compound[i]
					end
				else
          formatted << compound[i]
        end
			elsif x.to_i > 0 || x == "0"
				if compound[i+1].to_i > 0 || compound[i+1] == "0"
					formatted << compound[i..i+1].join.to_i
					compound.delete_at(i+1)
				else
					formatted << x.to_i
				end
			else
				formatted << x
			end
		end
	end

	formatted.each_with_index do |x,i|
		if x.class == String
			if x.is_element?
				formatted[i] = MASSES[x]
			end
		end
	end

	until formatted.contains_only(Float)
		formatted.flatten!
		formatted.format
	end

	return formatted.reduce(:+).round(3)


end

get '/' do
  erb :index
end

get '/form' do
  erb :form
end

post '/form' do
  @mass = molar_mass(params[:message])
  @compound = params[:message]
  erb :result
end
