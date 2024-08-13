class Generator(BaseGenerator):
    def data(self):
        x = var('x')

        # for picture problem
        x1 = randrange(1,5);
        x2 = randrange(1,5);
        x3 = randrange(5,10);
        x4 = randrange(5,10);
        x5 = randrange(5,10);
        
        CPs = set([x1,x2,x3,x4,x5]);
        cps = sorted(list(CPs));

        cp0 = min(cps);
        cp1 = max(cps);

        test_samp_list = [0]+cps+[10];
        ww = len(test_samp_list);
        
        ptest_pts = [(test_samp_list[j+1]+test_samp_list[j])/2 for j in range(ww-1)];
        peps = 10/120
        m1 = 0
        M1 = 10
        
        p_prime(x) = (x-x1)*(x-x2)*(x-x3)*(x-x4)*(x-x5);

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
            "p_prime": p_prime(x),
            "tm1": ticks1,
            "peps": peps,
            "pp1": pos_pts1,
            "np1": neg_pts1,
            "m1":m1,
            "M1":M1,
            "cp0": cp0,
            "cp1": cp1,

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
            "dgraph": plot(data["p_prime"],(data["cp0"]-0.5,data["cp1"]+.5)),
            "Show1": plot(0, (data["m1"],data["M1"]), ticks = [data["tm1"],[]], ymin = -1.2*data["peps"], ymax = 1.2*data["peps"], aspect_ratio = 1) + point(data["pp1"], size = 35, marker = "$+$")+point(data["np1"], size = 35, marker = "$-$")+point((data["m1"],0), size = 50, marker = "<")+point((data["M1"],0), size = 50, marker = ">"),
            "Show2": plot(0, (data["m2"],data["M2"]), ticks = [data["tm2"],[]], ymin = -1.2*data["feps"], ymax = 1.2*data["feps"], aspect_ratio = 1) + point(data["pp2"], size = 35, marker = "$+$")+point(data["np2"], size = 35, marker = "$-$")+point((data["m2"],0), size = 50, marker = "<")+point((data["M2"],0), size = 50, marker = ">"),
        }