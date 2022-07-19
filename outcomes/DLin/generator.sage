class Generator(BaseGenerator):
    def data(self):
        x = var('x')
        
        f_key = choice(["sqrt","cbrt","4rt","recip"])
        f_dict = {"sqrt": sqrt(x), "cbrt": x^(1/3), "4rt":x^(1/4), "recip":1/x}
        a_base = randrange(1,6);

        if f_key == "sqrt":
            a_power = choice([2,4])
        elif f_key == "cbrt":
            a_power = 3
        elif f_key == "4rt":
            a_power = 4
        else: #only remaining choice is f_key == "recip"
            a_power = choice([1,2])

        a = (a_base)^(a_power)
        f(x) = f_dict[f_key]

        y0 = f(a)
        deltax0 = x-a 
        derf(x) = derivative(f(x),x)
        slope = derf(a)

        if sign(slope) < 0:
            slope_sign_char = ""
        else:
            slope_sign_char = "+"

        L(x) = y0 + slope*(deltax0)





        return {
            "a": a,
            "f": f(x),
            "L": L(x),
            "y0": y0,
            "slope": slope,
            "deltax0": deltax0,
            "ssc": slope_sign_char,
            "pt": (a,y0),
            "w": 0.2*a,
        }
    
    @provide_data
    def graphics(data):
        return{
            "Show": plot(data["f"],(x,data["a"]-data["w"],data["a"]+data["w"]),color="red") + plot(data["L"],(x,data["a"]-data["w"],data["a"]+data["w"]),color="blue")+point(data["pt"],pointsize=20,color="purple"),
        }