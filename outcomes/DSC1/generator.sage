class Generator(BaseGenerator):
    def data(self):
        x = var('x')

        # for cubic function
        cps = [randrange(-9,10) for i in range(2)]
        cp0 = min(cps)
        cp1 = max(cps)

        dp = cp1-cp0
        
        if dp == 0:
            ptest_pts = [cp0-1.5,cp0+1.5]
            peps = 6/120
            m1 = cp0 - 3
            M1 = cp0 + 3
        else:
            ptest_pts = [cp0-dp/2,(cp0+cp1)/2,cp1+dp/2]
            peps = 3*dp/120
            m1 = cp0-dp
            M1 = cp1+dp
        
        B = randrange(1,9)*choice([-1,1])
        k = randrange(-33,50)

        cub = (B/3)*x^3 -(B/2)*(cp0+cp1)*x^2+B*cp0*cp1*x+k
        p_prime(x) = derivative(cub,x)

        ticks1 = cps

        pos_pts1 = [];
        neg_pts1 = [];

        for t in ptest_pts:
            if p_prime(t)>0:
                pos_pts1 += [(t,0.75*peps)]
            else:
                neg_pts1 += [(t,0.75*peps)]


        # for a root-y function
        s = sample([3,5,7,11],2)
        n = s[0]
        m = choice([2,s[1],s[1]])
        q = randrange(1,5)*choice([-1,1])

        p = q*(n+m)

        f(x) = x^((m+n)/n)-p*x^(m/n)
        f_prime(x) = derivative(f(x),x)

        ticks2 = sorted([0,q*m])
        df = abs(q*m)
        m2 = ticks2[0]-df
        M2 = ticks2[1]+df
        feps = 3*df/120

        if q>0:
            if (m-n)%2==0:
                pos_x2 = [q*m+df/2]
                neg_x2 = [-df/2,q*m/2]
            else: # so (m-n) is odd
                pos_x2 = [-df/2,q*m+df/2]
                neg_x2 = [q*m/2]
        else: # so q<0
            if (m-n)%2==0:
                pos_x2 = [q*m/2 , df/2]
                neg_x2 = [q*m-df/2]
            else: # so (m-n) is odd
                pos_x2 = [q*m-df/2, df/2]
                neg_x2 = [q*m/2]
        
        pos_pts2 = [(x,0.75*feps) for x in pos_x2]
        neg_pts2 = [(x,0.75*feps) for x in neg_x2]


        return {
            "cub": cub,
            "p_prime": p_prime(x),
            "tm1": ticks1,
            "peps": peps,
            "pp1": pos_pts1,
            "np1": neg_pts1,
            "m1":m1,
            "M1":M1,

            "f": f(x),
            "f_prime": f_prime(x),
            "tm2": ticks2,
            "feps": feps,
            "pp2": pos_pts2,
            "np2": neg_pts2,
            "m2": m2,
            "M2": M2,
        }

    @provide_data
    def graphics(data):

        return {
            "Show1": plot(0, (data["m1"],data["M1"]), ticks = [data["tm1"],[]], ymin = -1.2*data["peps"], ymax = 1.2*data["peps"], aspect_ratio = 1) + point(data["pp1"], size = 35, marker = "$+$")+point(data["np1"], size = 35, marker = "$-$")+point((data["m1"],0), size = 50, marker = "<")+point((data["M1"],0), size = 50, marker = ">"),
            "Show2": plot(0, (data["m2"],data["M2"]), ticks = [data["tm2"],[]], ymin = -1.2*data["feps"], ymax = 1.2*data["feps"], aspect_ratio = 1) + point(data["pp2"], size = 35, marker = "$+$")+point(data["np2"], size = 35, marker = "$-$")+point((data["m2"],0), size = 50, marker = "<")+point((data["M2"],0), size = 50, marker = ">"),
        }