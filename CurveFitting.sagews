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
︠964a6365-ac69-44d2-91ae-f5f969e424be︠



latex(model)
︡98e82907-629d-48aa-959d-3e5ee644cece︡{"stdout":"x \\ {\\mapsto}\\ -A e^{\\left(-\\frac{x}{T_{1}}\\right)} + y_{0}\n"}︡
︠83e0752c-7396-45c5-9ab1-3c76ce9f591e︠



import pandas

︠178ac81f-aea1-4af5-9996-f7c48fd6a62c︠
x,y = var('x,y')
capacity = 3 # thousand
growth_rate = 0.7 # population increases by 70% per unit of time
plot_vector_field(growth_rate*(1-y/capacity)*y, (x,0,5), (y,0,capacity*2))

︡9e020f99-8eb8-44d9-aa5f-061c29b7f6ce︡{"stderr":"Error in lines 4-4\nTraceback (most recent call last):\n  File \"/projects/fc1b0ee0-6bcd-4c6d-907c-d2d2689a97fe/.sagemathcloud/sage_server.py\", line 881, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\n  File \"/projects/sage/sage-6.9/local/lib/python2.7/site-packages/sage/misc/decorators.py\", line 550, in wrapper\n    return func(*args, **options)\n  File \"/projects/sage/sage-6.9/local/lib/python2.7/site-packages/sage/plot/plot_field.py\", line 206, in plot_vector_field\n    (f, g) = f_g\nTypeError: 'sage.symbolic.expression.Expression' object is not iterable\n"}︡
︠c10ea134-bf00-4eb7-a609-59c6e6b5b2d0sr︠

var('y z')
limits=20

def Y(l,m,theta,phi):
    return 1*gen_legendre_P(l,m,cos(theta))*exp(i*m*phi)
R_310(r)=(1-r/6)*(r/6)*e^(-r/3)
show(R_310)
PSI_310(r,theta,phi)=R_310(r)*Y(1,0,theta,phi)
def psi_310_xyz(x,y,z):
    rho = sqrt(x^2+y^2+z^2)
    theta=arccos(y/x)
    phi=arccos(z/rho)
    return PSI_310(rho,theta,phi)

implicit_plot3d(psi_310_xyz(x,y,z),(x,-limits,limits),(y,-limits,limits),(z,-limits,limits),)




phi, theta = var('phi, theta')
Y = spherical_harmonic(3, 1, theta, phi)
#rea = spherical_plot3d(abs(real(Y)), (phi,0,2*pi), (theta,0,pi), color='blue', opacity=0.6)
#ima = spherical_plot3d(abs(imag(Y)), (phi,0,2*pi), (theta,0,pi), color='red', opacity=0.6)
#(rea + ima).show(aspect_ratio=1)  # long time (4s on sage.math, 2011)
spherical_plot3d((real(Y)+imag(Y))*(real(Y)+imag(Y)).conjugate(),(phi,0,2*pi), (theta,0,pi),axes=false,plot_points=(200,200))
︡6560a7e7-6431-4c29-840d-6390776f677a︡
︠16831595-29cf-4ce5-861a-6fb3c10b428f︠









