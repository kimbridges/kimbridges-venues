import numpy as np, json
from PIL import Image
from scipy import ndimage as ndi
C=json.load(open("corners.json"))
C["13"]=[[133.5,529],[3088,528],[134,2104.5],[3091,2087.5]]
GEO={"12":[(-155.375,19.5),(-155.25,19.5),(-155.375,19.4375),(-155.25,19.4375)],
     "13":[(-155.375,19.4375),(-155.25,19.4375),(-155.375,19.375),(-155.25,19.375)]}
def homog(src,dst):
    A=[]
    for (x,y),(u,v) in zip(src,dst):
        A.append([x,y,1,0,0,0,-u*x,-u*y,-u]); A.append([0,0,0,x,y,1,-v*x,-v*y,-v])
    _,_,V=np.linalg.svd(np.array(A)); H=V[-1].reshape(3,3); return H/H[2,2]
def apply(H,x,y):
    w=H[2,0]*x+H[2,1]*y+H[2,2]; return (H[0,0]*x+H[0,1]*y+H[0,2])/w,(H[1,0]*x+H[1,1]*y+H[1,2])/w
labels={}; Hs={}
for s in ["12","13"]:
    img=np.array(Image.open(f"sheet{s}_veg.png"))<128
    Hs[s]=homog(GEO[s],C[s])            # geo -> pixel
    # mask outside neatline
    from PIL import ImageDraw
    nl=Image.new("1",(img.shape[1],img.shape[0]),0); dr=ImageDraw.Draw(nl)
    tl,tr,bl,br=[tuple(p) for p in C[s]]
    dr.line([tl,tr,br,bl,tl],fill=1,width=3)
    img=img|np.array(nl,dtype=bool)
    line=ndi.binary_dilation(img, iterations=1)
    lab,n=ndi.label(~line)               # 4-connectivity regions
    sz=ndi.sum(np.ones_like(lab),lab,index=np.arange(n+1)); small=sz<600   # text holes (<~1.2 ha)
    small[0]=True; lab[small[lab]]=0
    labels[s]=(lab,n,img)
    print(s,"regions",n)
json.dump({s:Hs[s].tolist() for s in Hs}, open("homog.json","w"))
# target grid in OHD lon/lat
res=0.00005
lon=np.arange(-155.330,-155.275,res)+res/2; lat=np.arange(19.460,19.420,-res)-res/2
LON,LAT=np.meshgrid(lon,lat)
out=np.zeros(LON.shape,dtype=np.int32); lineg=np.zeros(LON.shape,dtype=bool)
for s,off in [("12",0),("13",100000)]:
    lab,n,img=labels[s]
    inside=(LAT>=19.4375) if s=="12" else (LAT<19.4375)
    px,py=apply(Hs[s],LON,LAT); px=np.round(px).astype(int); py=np.round(py).astype(int)
    ok=inside&(px>=0)&(py>=0)&(px<lab.shape[1])&(py<lab.shape[0])
    v=lab[py[ok],px[ok]]; out[ok]=np.where(v>0,v+off,0); lineg[ok]=img[py[ok],px[ok]]
# fill line/text cells with nearest region id
idx=ndi.distance_transform_edt(out==0,return_distances=False,return_indices=True)
filled=out[idx[0],idx[1]]
np.save("regions_grid.npy",filled); np.save("lines_grid.npy",lineg)
json.dump({"lon0":float(lon[0]-res/2),"lat0":float(lat[0]+res/2),"res":res,"nrow":int(LON.shape[0]),"ncol":int(LON.shape[1])},open("grid.json","w"))
u=np.unique(filled); print("grid",filled.shape,"regions in window",len(u))
