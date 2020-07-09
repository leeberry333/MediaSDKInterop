#define WS 640
__kernel void ProcessY(    __global uchar* src,     __global uchar* dst,
                        int param1,     int param2,
                        __global short* pD)
{
    int x = get_global_id(0);
    int y = get_global_id(1);
    int w = get_global_size(0);
    int h = get_global_size(1);
    if(x>pD[0] & y>pD[1] & x<pD[2] & y<pD[3])
    {
        short v = 128+
            ((src[(y-1)*w + (x-1)]+2*src[(y-1)*w + (x)]+src[(y-1)*w + (x+1)])-
            (src[(y+1)*w + (x-1)]+2*src[(y+1)*w + (x)]+src[(y+1)*w + (x+1)]));
        dst[y*w + x] = clamp(v,(short)50,(short)200);
    }
    else
    {
        dst[y*w + x] = src[y*w + x];
    }
}

__kernel void Mouse(int x, int y,int W,int H,int flag,int p1,int p2,__global short* pD)
{
    if(pD[0]==0 & pD[1]==0 & pD[2]==0 & pD[3]==0)
    {// init data
        pD[0] = clamp((W>>1) - (WS>>1),0,W);
        pD[1] = clamp((H>>1) - (WS>>1),0,H);
        pD[2] = clamp((W>>1) + (WS>>1),0,W);
        pD[3] = clamp((H>>1) + (WS>>1),0,H);
    }
    if(flag)
    {// recalc ROI
        pD[0] = clamp(x - (WS>>1),0,W);
        pD[1] = clamp(y - (WS>>1),0,H);
        pD[2] = clamp(x + (WS>>1),0,W);
        pD[3] = clamp(y + (WS>>1),0,H);
    }
}
