
#define HexColor(hex)        [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1]
//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

// MainScreen Height&Width
#define Main_Screen_Height_WL      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width_WL       [[UIScreen mainScreen] bounds].size.width
#define Main_Screen_Proportion_WL       ([[UIScreen mainScreen] bounds].size.width／[[UIScreen mainScreen] bounds].size.height)

#define cellId_WL     [NSString stringWithFormat:@"%@cellSection%ldrow%ld",self.class,(long)indexPath.section,(long)indexPath.row]
#define cellId_wl_ind(k)     [NSString stringWithFormat:@"%@cellSection%ldrow%ld%@",self.class,(long)indexPath.section,(long)indexPath.row,k]

#import "UIView+WExtension.h"
#import "UIView+WLBlockGesture.h"
#import "UIView+WLCornerRadius.h"
#import "UIImage+WLColor.h"
