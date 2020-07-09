__kernel void ProcessY(
    __global uchar* src,
    __global uchar* dst,
        int param1,
    int param2)
{
    int x = get_global_id(0);
    int y = get_global_id(1);
    int w = get_global_size(0);
    dst[y*w + x] = src[y*w + x];
}
__kernel void ProcessUV(
    __global uchar2* src,
    __global uchar2* dst,
    int param1,
    int param2)
{
    int x = get_global_id(0);
    int y = get_global_id(1);
    int w = get_global_size(0);

    dst[y*w + x] = src[y*w + x];
}
