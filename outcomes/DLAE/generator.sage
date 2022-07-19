class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        
        n = randrange(2,6)
        b = randrange(1,4)
        a = b^n
        q = randrange(2,7)*choice([-1,1])
        r = a + (q*n*b^(n-1))/1000.0

        est = b+q/1000.000

        if n == 2:
            root_LaTeX_str = "\\sqrt"
        else:
            root_LaTeX_str = "\\sqrt[" + str(n) + "]"
        
        



        return {
            "r": round(r,4),
            "est": round(est,3),
            "n": n,
            "a": a,
            "root_LaTeX_str": root_LaTeX_str,
        }