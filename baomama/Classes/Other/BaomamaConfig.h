//宝妈妈api网络配置

//网络基站
#define kBasePath @"http://api.yi18.net"
//图片基站
#define kBaseImagePath @"http://www.yi18.net/"
//常识列表api 参数：page｜页数 limit｜每页数量 type｜排序（id最新，count最热）?page=2&limit=10&type=id&id=6
#define kLorePath @"lore/list"
//常识详情api ?id=2
#define kLoreShowPath @"lore/show"
//食谱列表api 参数：page｜页数 limit｜每页数量 type｜排序（id最新，count最热）?page=2&limit=10&type=id&id=6
#define kCookPath @"cook/list"
//食谱详情api ?id=1
#define kCookShowPath @"cook/show"

//食谱顶级分类
#define kCookCatePath @"cook/cookclass?id=6"