class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        h = var('h')
        
        n = choice([2,3,4,-1]);

        if n == -1:
            f(x) = choice([-1,1])*randrange(1,10)*x^n
        else:
            f(x) = randrange(1,10)*choice([-1,1])*x^n + randrange(-9,10)*x + randrange(-9,10)



        return {
            "n": n,
            "f": f(x),
            "deriv": derivative(f(x),x)
        }