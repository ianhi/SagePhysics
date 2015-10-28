def import_csv(file):
    f = open(file, 'r')
    xArr=[]
    yArr=[]
    line=f.readline()
    while(line !=''):
        xy=line.split(',')
        xArr.append(float(xy[0]))
        yArr.append(float(xy[1]))
        line=f.readline()
    return xArr,yArr
def curve_fit(model,data, sigma = None, initial_guess = None, parameters = None, variables = None, solution_dict = False):
    import numpy
    if not isinstance(data, numpy.ndarray):
        try:
            data = numpy.array(data, dtype = float)
        except (ValueError, TypeError):
            raise TypeError("data has to be a list of lists, a matrix, or a numpy array")
    elif data.dtype == object:
        raise ValueError("the entries of data have to be of type float")

    if data.ndim != 2:
        raise ValueError("data has to be a two dimensional table of floating point numbers")

    from sage.symbolic.expression import Expression

    if isinstance(model, Expression):
        if variables is None:
            variables = list(model.arguments())
        if parameters is None:
            parameters = list(model.variables())
            for v in variables:
                parameters.remove(v)
    if data.shape[1] != len(variables) + 1:
        raise ValueError("each row of data needs %d entries, only %d entries given" % (len(variables) + 1, data.shape[1]))

    if parameters is None or len(parameters) == 0 or \
       variables is None or len(variables) == 0:
        raise ValueError("no variables given")

    if initial_guess is None:
        initial_guess = len(parameters) * [1]

    if not isinstance(initial_guess, numpy.ndarray):
        try:
            initial_guess = numpy.array(initial_guess, dtype = float)
        except (ValueError, TypeError):
            raise TypeError("initial_guess has to be a list, tuple, or numpy array")
    elif initial_guess.dtype == object:
        raise ValueError("the entries of initial_guess have to be of type float")

    if len(initial_guess) != len(parameters):
        raise ValueError("length of initial_guess does not coincide with the number of parameters")

    if isinstance(model, Expression):
        var_list = variables + parameters
        var_names = [str(_) for _ in var_list]
        func = model._fast_float_(*var_names)
    else:
        func = model

    def function(x_data, *params):
        result = numpy.zeros(len(x_data))
        for row in xrange(len(x_data)):
            fparams = numpy.hstack((x_data[row], params)).tolist()
            result[row] = func(*fparams)
        return result

    x_data = data[:, 0:len(variables)][:]
    y_data = data[:, -1]

    from scipy.optimize import curve_fit

    estimated_params, cov = curve_fit(function,x_data,y_data,p0=initial_guess,sigma=sigma)
    err=numpy.sqrt(numpy.diag(cov))

    for i in range(0,len(estimated_params)):
        print(str(parameters[i])+": "+str(estimated_params[i])+" +/- "+str(err[i]))
    if isinstance(estimated_params, float):
        estimated_params = [estimated_params]
    else:
        estimated_params = estimated_params.tolist()
    if solution_dict:
       dict = {}
       for item in zip(parameters, estimated_params):
           dict[item[0]] = item[1]
       return dict

#    return [item[0] == item[1] for item in zip(parameters, estimated_params)],numpy.sqrt(numpy.diag(cov)).tolist()
    return estimated_params,numpy.sqrt(numpy.diag(cov)).tolist()
