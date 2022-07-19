class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        
        S = sample(range(-9,10),3);
        a = S[0];
        t1 = x-S[0];
        t2 = x-S[1];
        b1 = x-S[0];
        b2 = x-S[2];

        top = expand(t1*t2);
        bottom = expand(b1*b2);

        f(x) = top/bottom;
        g(x) = t2/b2;



        return {
            "a": a,
            "f": f(x),
            "L": g(a),
        }