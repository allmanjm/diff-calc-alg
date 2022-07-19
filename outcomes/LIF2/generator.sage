class Generator(BaseGenerator):
    def data(self):
        x = var('x');
        
        pm_dict = {"+":1,"-":-1}
        LaTeXsign_dict = {"+":"\\infty", "-":"-\\infty"};

        # stuff for Task1
        A,B,C,D,E,F,G = var('A,B,C,D,E,F,G');
        
        numer = A*x^2 + B*x + C;
        denom = D*x^3 + E*x^2 + F*x + G;
        
        f1(x) = numer/denom;
        
        pm1 = choice(["+","-"]);

        u = randrange(1,25);
        v = randrange(1,25);
        r_sign = choice([-1,1]);
        r = r_sign*u/v;

        L0 = choice([0,r,"+","-"]);
        if L0 == r:
            L1 = r
            answer1 = "A = " + str(r_sign*u) + ", D = 0, E = " + str(v)       
        elif L0 == 0:
            L1 = 0
            answer1 = "D = 1"
        else: 
            L1 = LaTeXsign_dict[L0]

            if L0 == "+" and pm1 == "+":
                answer1 = "A = 1, D = 0, E = 0, F = 1"
            elif L0 == "+" and pm1 == "-":
                answer1 = "A = 1, D = 0, E = 0, F = -1"
            elif L0 == "-" and pm1 == "+":
                answer1 = "A = 1, D = 0, E = 0, F = -1"
            else:
                answer1 = "A = 1, D = 0, E = 0, F = 1"

            
            




        # stuff for Task2
        pm2 = choice(["+","-"]);
        top_cs = [choice([0,randrange(1,10)*choice([-1,1])]) for i in range(4)];
        tcs = sample(top_cs + [randrange(1,10)],5);
        bottom_cs = [choice([0,randrange(1,10)*choice([-1,1])]) for i in range(4)];
        bcs = sample(bottom_cs + [randrange(1,10)],5);
        
        top = sum(tcs[i]*x^i for i in range(5));
        bot = sum(bcs[i]*x^i for i in range(5));

        f2(x) = top/bot;

        def deg(poly,x):
            if poly == 0:
                d = -Infinity;
            else:
                d=0;
                it_poly=derivative(poly,x);
                while it_poly != 0:
                    it_poly = derivative(it_poly,x)
                    d += 1
            return d
        
        dt = deg(top,x);
        db = deg(bot,x);
        bound_check_list = [abs(tcs[j]/tcs[dt]) for j in range(dt)]+[abs(bcs[i]/bcs[db]) for i in range(db)];
        Cauchy_Root_Bound = ceil(1+max(bound_check_list));
        test = pm_dict[pm2]*(Cauchy_Root_Bound + 1);

        relative_degree = dt-db;

        if relative_degree < 0:
            answer2 = 0
        elif relative_degree > 0:
            if f2(test) > 0:
                answer2 = "+\\infty"
            else:
                answer2 = "-\\infty"
        else: # so relative_degree IS zero
            answer2 = Rational(derivative(top,x,dt)/derivative(bot,x,db))

        



        return {
            "a1": LaTeXsign_dict[pm1],
            "f1": f1(x),
            "L1": L1,
            "answer1": answer1,
            "a2": LaTeXsign_dict[pm2],
            "f2": f2(x),
            "L2": answer2,
        }