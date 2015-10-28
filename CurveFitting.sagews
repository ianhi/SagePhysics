︠a6b01b36-62bc-4b71-b95c-2293170eeecf︠
import Curve_Fitting

#--------------DEFINE MODEL----------------
var('y0 A T1')
model(x)=y0-A*e^(-x/T1)
pretty_print(model)
#-------------Do Stuff with data-----------
xData,yData=Curve_Fitting.import_csv('data.csv')
for i in range(0,len(xData)):
    if xData[i]<15:
        yData[i]=-yData[i]
data=zip(xData,yData)

#-------------Fit and plot-----------------
params, sigma = Curve_Fitting.curve_fit(model,data)

list_plot(data)+plot(model(A=params[0],T1=params[1],y0=params[2]),0,60,linestyle='dashed',color='red',legend_label='$'+latex(model)+'$')
︡e40d0066-098a-41eb-b48d-c087a442368e︡{"stdout":"(y0, A, T1)\n"}︡{"html":"<div align='center'>$\\displaystyle x \\ {\\mapsto}\\ -A e^{\\left(-\\frac{x}{T_{1}}\\right)} + y_{0}$</div>"}︡{"stdout":"A: 11.2231224449 +/- 0.191621520253"}︡{"stdout":"\nT1: 21.6849697725 +/- 1.21750803811\ny0: 5.38909029582 +/- 0.225516116478\n"}︡{"once":false,"file":{"show":true,"uuid":"100e2172-a807-4c2d-9680-e07d129cc39c","filename":"/projects/fc1b0ee0-6bcd-4c6d-907c-d2d2689a97fe/.sage/temp/compute3-us/15300/tmp_RmnVQP.svg"}}︡{"html":"<div align='center'></div>"}︡
︠964a6365-ac69-44d2-91ae-f5f969e424bes︠





load('curve_fit_to_data.py')
curve_fit_to_data()

︡227712a5-b6a6-4e0e-a3e5-85bcd0eaf45e︡{"stdout":"******** RESULTS FROM FIT ******** (by curve_fit_to_data.py)"}︡{"stdout":"\nFit Function:  gaussian\n\nNumber of Data Points =     100, Number of Parameters = 4\n\nCovariance Matrix : \n[[  1.39094587e-01   7.25581512e-02  -3.93450620e-06  -1.81880122e-04]\n [  7.25581512e-02   8.82251672e+01   2.72965371e-04  -1.52090997e-02]\n [ -3.93450620e-06   2.72965371e-04   1.14990728e-05  -1.01225111e-07]\n [ -1.81880122e-04  -1.52090997e-02  -1.01225111e-07   7.37568053e-06]] \n\nCorrelation Matrix :\n  1.000000   0.020713  -0.003111  -0.179568\n  0.020713   1.000000   0.008570  -0.596220\n -0.003111   0.008570   1.000000  -0.010991\n -0.179568  -0.596220  -0.010991   1.000000\n\nEstimated parameters and uncertainties (with initial guesses)\n   p[0] =    8.91342 +/-    0.37295      (  10.00000)\n   p[1] =  461.84244 +/-    9.39283      (  40.00000)\n   p[2] = 1173.23770 +/-    0.00339      (1171.00000)\n   p[3] =    0.20012 +/-    0.00272      (   1.00000)\n\nChi-Squared/dof =    1.16973, CDF =   12.24578%\n"}︡{"stderr":"/projects/sage/sage-6.9/local/lib/python2.7/site-packages/matplotlib-1.4.3-py2.7-linux-x86_64.egg/matplotlib/__init__.py:1318: UserWarning:  This call to matplotlib.use() has no effect\nbecause the backend has already been chosen;\nmatplotlib.use() must be called *before* pylab, matplotlib.pyplot,\nor matplotlib.backends is imported for the first time.\n\n  warnings.warn(_use_error_msg)\n"}︡{"once":false,"file":{"show":true,"uuid":"2f9ee2e4-d93f-4b8c-acb0-87e4ca2bfc90","filename":"95dc3491-3945-4fe7-bf32-c8faa20ec294.svg"}}︡
︠4122a80b-48ee-4ba1-95e6-20874c2c8dc4s︠
load('curve_fit_to_data.py')
import numpy
x_data, y_data, y_sigma = numpy.loadtxt('data.csv',delimiter=',', unpack=True)
def gaussian(x,*p) :
    # A gaussian peak with:
        #   Constant Background          : p[0]
        #   Peak height above background : p[1]
        #   Central value                : p[2]
        #   Standard deviation           : p[3]
    return p[0]+p[1]*numpy.exp(-1*(x-p[2])**2/(2*p[3]**2))
def gauss2(x,y0,A,xoff,tau):
    return y0+A*numpy.exp(-1*(x-xoff)**2/(2*tau**2))
def NMR_exp(x,y0,A,T1):
    return y0-A*numpy.exp(-x/T1)
plot(NMR_exp(x,1,1,1),0,20)

curve_fit_to_data(NMR_exp,x_data,y_data,y_sigma)
︡1a433ea0-d253-4dd7-9230-351f5e3d7f48︡{"once":false,"file":{"show":true,"uuid":"bb34f4e4-6c33-4aaa-bb5b-86f34e66cba6","filename":"/projects/fc1b0ee0-6bcd-4c6d-907c-d2d2689a97fe/.sage/temp/compute3-us/25275/tmp_l9t7pj.svg"}}︡{"html":"<div align='center'></div>"}︡{"stdout":"******** RESULTS FROM FIT ******** (by curve_fit_to_data.py)\nFit Function:  NMR_exp\n\nNumber of Data Points =      14, Number of Parameters = 3\n\nCovariance Matrix : \n[[ inf  inf  inf]\n [ inf  inf  inf]\n [ inf  inf  inf]] \n\nCorrelation Matrix :\n       nan        nan        nan\n       nan        nan        nan\n       nan        nan        nan\n\nEstimated parameters and uncertainties (with initial guesses)\n**** BAD FIT ****\nParameters were:  [ 1.44940103  0.37977563  0.02069106]\nChi-Squared/dof for these parameter values =    0.43668, CDF =   94.03080%\nUncertainties not calculated.\n\nTry a different initial guess for the fit parameters.\nOr if these parameters appear close to a good fit, try giving\n    the fitting program more time by increasing the value of maxfev.\n"}︡{"stderr":"Error in lines 16-16\nTraceback (most recent call last):\n  File \"/projects/fc1b0ee0-6bcd-4c6d-907c-d2d2689a97fe/.sagemathcloud/sage_server.py\", line 881, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\n  File \"./curve_fit_to_data.py\", line 221, in curve_fit_to_data\n    fit.plot(x_func, initial_plot, 'g-', label=\"Start\", linestyle=\"--\")\nNameError: global name 'initial_plot' is not defined\n"}︡
︠ea5c6adb-02ad-43ee-ac8a-03dad94a9176︠
︠a33a1626-972e-4e5d-af15-77dda336a793s︠
import inspect
print(inspect.getargspec(NMR_exp))
︡6b6a63e9-4226-4062-b49c-333eb420b6c5︡{"stdout":"ArgSpec(args=['x', 'y0', 'A', 'T1'], varargs=None, keywords=None, defaults=None)\n"}︡
︠d16848ca-1c57-4cc5-a1c8-622c5095bd25s︠
NMR_exp.func_code.co_argcount
︡f7835137-98f2-43d5-8ec6-ecff8decc2d7︡{"stdout":"4\n"}︡
︠6699c471-b15e-4554-a91a-47bbaebc44e2︠










