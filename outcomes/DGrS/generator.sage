class Generator(BaseGenerator):
    def data(self):
        x = var('x')

        k = choice([1,2,3]);
        c = randrange(1,10);
        A = randrange(1,50);
        s = choice([1,-1]);

        f(x)=A*x^k/(x^2+s*c^2);

        f_0 = solve(f(x)==0,x,algorithm = 'sympy', domain='real');
        f_u = solve(denominator(f(x))==0,x,algorithm = 'sympy', domain='real');
        df_0 = solve(derivative(f(x),x)==0,x,algorithm = 'sympy', domain='real');
        df_u = solve(denominator(derivative(f(x),x))==0,x,algorithm = 'sympy', domain='real');
        ddf_0 = solve(derivative(f(x),x,2)==0,x,algorithm = 'sympy', domain='real');
        ddf_u = solve(denominator(derivative(f(x),x,2))==0,x,algorithm = 'sympy', domain='real');

        special_points0 = [x.subs(sol) for sol in f_0];
        special_points1 = [x.subs(sol) for sol in df_0];
        special_points2 = [x.subs(sol) for sol in ddf_0];
        special_points = list(set(special_points0 + special_points1 + special_points2));
        special_values = list(set([f(t) for t in special_points]));



        und_points0 = [x.subs(sol) for sol in f_u];
        und_points1 = [x.subs(sol) for sol in df_u];
        und_points2 = [x.subs(sol) for sol in ddf_u];
        und_points = list(set(und_points0 + und_points1 + und_points2));

        really_special_points = list(set(und_points + special_points));

        sp = Set(really_special_points).difference(Set(und_points0));

        special_points2D = [(t,f(t)) for t in sp];


        leftX = min(really_special_points);
        rightX = max(really_special_points);
        topY = max(special_values);
        bottomY = min(special_values);

        distX = rightX - leftX;
        distY = (topY - bottomY)/3;

        x0 = leftX - distX;
        x1 = rightX + distX;

        if k==1 and s==1:
            y_cutoff = A/3;
        else:
            y_cutoff = 2*A;

        y0 = min(-y_cutoff,bottomY - distY);
        y1 = max(y_cutoff,topY + distY);


        if k == 1:
            ha = 0
            L = 0
        elif k == 2:
            ha = A
            L = A
        else:
            ha = A*x
            L = "\\pm \\infty"

        # helper function for offsetting funny +/- signs on tick marks
        def zero_offset_helper(t,h):
            if t==0:
                out = t+h;
            else:
                out = t;
            
            return out


        # begin definition of sign_chart_data function
        def sign_chart_data(f): 
            # output sign chart data as a tuple, given a (rational) expression f
            # returns a tuple: (m,M,eps,pos_pts,neg_pts)
            # m is the far left x-coordinate
            # M is the far right x-coordinate
            # eps is the "ymax" on the sign chart
            # pos_pts is a list of points where we should place a "+" sign
            # neg_pts is a list of points where we should place a "-" sign

            g(x) = f;
            zero_sols = solve(g(x)==0,x,algorithm="sympy",domain="real");
            und_sols = solve(denominator(g(x))==0,x,algorithm="sympy",domain="real");
            ticks = sorted([n(x.subs(z),digits=3) for z in zero_sols]+[n(x.subs(u),digits=3) for u in und_sols]);
            L = len(ticks);
            if L == 0:
                m = -3;
                M = 3;
                d = 2;
                eps = 6/120;
                test_pts = [0];
            elif L == 1:
                m = ticks[0]-3;
                M = ticks[0]+3;
                d = 2;
                eps = 6/120;
                test_pts = [ticks[0]-1.5,ticks[0]+1.5];
            else:
                d = (ticks[L-1] - ticks[0])/(L-1);
                m = ticks[0]-d;
                M = ticks[L-1]+d;
                eps = (2*d+ticks[L-1]-ticks[0])/120;
                test_pts = [ticks[0]-d/2];
                i = 1;
                while i<L:
                    test_pts += [(ticks[i]+ticks[i-1])/2];
                    i += 1;
                test_pts += [ticks[L-1]+d/2];

            pos_pts = [];
            neg_pts = [];
    
            for t in test_pts:
                if g(t)>0:
                    pos_pts += [(zero_offset_helper(t,d/35),0.75*eps)];
                else:
                    neg_pts += [(zero_offset_helper(t,d/35),0.75*eps)];
    
            return tuple([m,M,eps,ticks,pos_pts,neg_pts])

            #end definition of sign_chart_data function.

        scd0 = sign_chart_data(f(x));
        scd1 = sign_chart_data(derivative(f(x),x));
        scd2 = sign_chart_data(derivative(f(x),x,2));





        return {
            "sp2D": special_points2D,
            "up0": und_points0,
            "L": L,
            "f": f(x),
            "x0": x0,
            "x1": x1,
            "y0": y0,
            "y1": y1,
            "ha": ha,
            "scd0": scd0,
            "scd1": scd1,
            "scd2": scd2,
        }

    @provide_data
    def graphics(data):

        m0 = data["scd0"][0];
        m1 = data["scd1"][0];
        m2 = data["scd2"][0];

        M0 = data["scd0"][1];
        M1 = data["scd1"][1];
        M2 = data["scd2"][1];

        eps0 = data["scd0"][2];
        eps1 = data["scd1"][2];
        eps2 = data["scd2"][2];

        ticks0 = data["scd0"][3];
        ticks1 = data["scd1"][3];
        ticks2 = data["scd2"][3];

        pp0 = data["scd0"][4];
        pp1 = data["scd1"][4];
        pp2 = data["scd2"][4];

        np0 = data["scd0"][5];
        np1 = data["scd1"][5];
        np2 = data["scd2"][5];

        return {
            "sc0": plot(0, (m0,M0), ticks = [ticks0,[]], ymin = -1.2*eps0, ymax = 1.2*eps0, aspect_ratio = 1) + point(pp0, size = 35, marker = "$+$")+point(np0, size = 35, marker = "$-$")+point((m0,0), size = 50, marker = "<")+point((M0,0), size = 50, marker = ">"),
            "sc1": plot(0, (m1,M1), ticks = [ticks1,[]], ymin = -1.2*eps1, ymax = 1.2*eps1, aspect_ratio = 1) + point(pp1, size = 35, marker = "$+$")+point(np1, size = 35, marker = "$-$")+point((m1,0), size = 50, marker = "<")+point((M1,0), size = 50, marker = ">"),
            "sc2": plot(0, (m2,M2), ticks = [ticks2,[]], ymin = -1.2*eps2, ymax = 1.2*eps2, aspect_ratio = 1) + point(pp2, size = 35, marker = "$+$")+point(np2, size = 35, marker = "$-$")+point((m2,0), size = 50, marker = "<")+point((M2,0), size = 50, marker = ">"),
            "graph": plot(data["f"],(x,data["x0"],data["x1"]),ymin=data["y0"],ymax=data["y1"],color="red",detect_poles=True) + plot(data["ha"],(x,data["x0"],data["x1"]),ymin=data["y0"],ymax=data["y1"],linestyle="--") + point(data["sp2D"], pointsize = 35, color = "purple") + sum([line([(t,data["y0"]-1),(t,data["y1"]+1)],linestyle="--") for t in data["up0"]])
        }