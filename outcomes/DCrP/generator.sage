class Generator(BaseGenerator):
    def data(self):
        x = var('x')

        # for cubic function
        cps = [randrange(-9,10) for i in range(2)]
        cp0 = min(cps)
        cp1 = max(cps)
        
        if cp0 == cp1:
            CPcub_str = "\\{" + str(cp0) + "\\}"
        else:
            CPcub_str = "\\{" + str(cp0) + "," + str(cp1) + "\\}"
        
        B = randrange(1,9)*choice([-1,1])
        k = randrange(-33,50)

        cub = (B/3)*x^3 -(B/2)*(cp0+cp1)*x^2+B*cp0*cp1*x+k

        # for a root-y function
        top_bottom = sample([3,5,7,11],2)
        n = top_bottom[0]
        m = top_bottom[1]
        q = randrange(1,5)*choice([-1,1])

        p = q*(n+m)

        f(x) = x^((m+n)/n)-p*x^(m/n)

        CPf_str = "\\{ 0 , " + str(q*m) + "\\}"

        # for rational function
        A = randrange(2,10)
        c = randrange(1,10)
        w = floor(sqrt(4*c))
        b = randrange(0,w)*choice([-1,1])

        v = choice([1,2,3])

        num = A*x^v 
        denom = x^2 + b*x + c 

        if v == 1:
            CPg_str = "\\{ \\pm \\sqrt{" + str(c) + "} \\}"
        elif v == 2:
            if b==0:
                CPg_str = "\\{ 0 \\}"
            else:
                CPg_str = "\\{0, " + str(-2*c/b) +"\\}"
        else: #only option now is v == 3
            disc = (2*b)^2-4*(2*c);
            if disc < 0:
                CPg_str = "\\{0\\}"
            else:
                if type(sqrt(disc)) == Integer:
                    w_plus = -b+sqrt(disc)/2;
                    w_minus = -b - sqrt(disc/2);
                    CPg_str = "\\{0," + str(w_plus) + "," + str(w_minus) + "\\}"
                else:
                    CPg_str = "\\{0, \\frac{" + str(-2*b) + "+ \\sqrt{" + str(disc) + "}}{2}, \\frac{" + str(-2*b) + "- \\sqrt{" + str(disc) + "}}{2}\\}"

       



        return {
            "cub": cub,
            "CPcub_str": CPcub_str,
            "f": f(x),
            "CPf_str": CPf_str,
            "num": num,
            "denom": denom,
            "CPg_str": CPg_str
        }