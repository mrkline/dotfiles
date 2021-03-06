def phi(z):
	"""The standard normal distribution function"""
	return e^(-(1/2) * z^2) / sqrt(2 * pi)

def Phi(z):
	"""The standard normal cumulative distribution function"""
	y = var('y')
	return integral(phi(y), y, -infinity, z)

def choose(n, r):
	"""Returns n choose r"""
	return factorial(n) / (factorial(n - r) * factorial(r))
