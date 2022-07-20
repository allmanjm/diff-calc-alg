class Generator(BaseGenerator):
    def data(self):
        x = var('x')

        
        

        # for chain rule function
        samp_rts = sample(range(-9,10),2);
        r1 = min(samp_rts);
        r2 = max(samp_rts);
        b = -1*(r1+r2);
        c = r1*r2;
        
        n = choice([5,13,25]); #want n>=3 and 2n-1 to be perfect square

        if n == 5:
            rho1 = -b/2 - (r1-r2)/(6);
            rho2 = -b/2 + (r1-r2)/(6);
        elif n== 13:
            rho1 = -b/2 - (r1-r2)/(10);
            rho2 = -b/2 + (r1-r2)/(10);
        else:
            rho1 = -b/2 - (r1-r2)/(14);
            rho2 = -b/2 + (r1-r2)/(14);
        

        ticks1 = sorted([r1,r2,rho1,rho2]);
        span = ticks1[3]-ticks1[0];
        w = span/3;

        m1 = min(ticks1)-w;
        M1 = max(ticks1)+w; 
        dp = M1 - m1;       
        peps = dp/120;

        p(x) = (x^2 + b*x + c)^n;
        p_2prime(x) = derivative(p(x),x,2)

        test_pts1 = [ticks1[0]-w/2,(ticks1[0]+ticks1[1])/2,(ticks1[1]+ticks1[2])/2,(ticks1[2]+ticks1[3])/2,ticks1[3]+w/2];

        pos_pts1 = [];
        neg_pts1 = [];

        hh = w/20;

        def zero_offset(t,h):
            if t == 0:
                out = t+h
            else:
                out = t 
            
            return out 

        for t in test_pts1:
            if p_2prime(t)>0:
                pos_pts1 += [(zero_offset(t,hh),0.75*peps)]
            else:
                neg_pts1 += [(zero_offset(t,hh),0.75*peps)]


        # for polynomial
        A = randrange(1,6)*choice([-1,1]);
        nn = randrange(1,5);
        mm = choice([1,2]);
        c1 = randrange(-5,6);
        c0 = randrange(-5,6);
        h = randrange(1,5);

        f(x) = c0 + c1*x + A*sum(binomial(mm,j)*h^(mm-j)/((j+nn+1)*(j+nn+2))*x^(j+nn+2) for j in range(mm+1));
        f_2prime(x) = derivative(f(x),x,2)

        ticks2 = [-h,0];
        m2 = -2*h;
        M2 = h;
        feps = 3*h/120;
        test_pts2 = [-h-h/2,-h/2,h/2];

        pos_pts2 = [];
        neg_pts2 = [];

        for tt in test_pts2:
            if f_2prime(tt)>0:
                pos_pts2 += [(tt,0.75*feps)]
            else:
                neg_pts2 += [(tt,0.75*feps)]


        return {
            "p": p(x),
            "p_2prime": p_2prime(x),
            "tm1": ticks1,
            "peps": peps,
            "pp1": pos_pts1,
            "np1": neg_pts1,
            "m1": m1,
            "M1": M1,
            
            "f": f(x),
            "f_2prime": f_2prime(x),
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