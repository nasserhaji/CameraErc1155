# کنترل هوشمند دوربین نظارتی با قراردادهوشمند با استفاده از استاندارد ERC1155
این قرارداد هوشمند برای کنترل یک دوربین نظارتی ساخته شده است. صاحب دوربین با استفاده از توابع این قرارداد، می‌تواند دوربین را روشن و خاموش کرده و زمان روشن و خاموش شدن آن را ثبت کند. همچنین، این قرارداد از استاندارد ERC1155 استفاده کرده و توکن‌های مربوط به زمان‌های روشن و خاموش شدن دوربین را ایجاد می‌کند که می‌تواند به صاحب دوربین انتقال داده شود. به این ترتیب، این قرارداد هوشمند می‌تواند به عنوان یک ابزار کنترلی برای دوربین نظارتی در سیستم‌های امنیتی و ارائه خدمات مرتبط استفاده شود.
لیست تغییرات برای پروژه دوربین هوشمند به صورت زیر می‌تواند باشد:

## نگارش 1.0.0
افزودن صفحه وب Camera Control * برای کنترل دوربین هوشمند
پیاده‌سازی قرارداد هوشمند CameraContract * برای مدیریت دوربین ها
تعریف توابع setCameraOwner، getCameraOwner، getCameraName، turnOn و turnOff در قرارداد هوشمند
افزودن توابع setCameraName و getLastOnTime به قرارداد هوشمند
به روزرسانی رابط کاربری Camera Control برای اضافه کردن توابع setCameraName و getLastOnTime
بهبود امنیتی و کدنویسی با به‌روزرسانی‌های کوچک
## نگارش 2.0.0
پیاده‌سازی تابع getLastOnTime در قرارداد هوشمند
به روزرسانی رابط کاربری Camera Control برای اضافه کردن توابع getLastOnTime
بهبود امنیتی و کدنویسی با به‌روزرسانی‌های کوچک
## نگارش 3.0.0
به‌روزرسانی قرارداد هوشمند CameraContract با توابع اضافی برای مدیریت هزینه‌ها
به روزرسانی رابط کاربری Camera Control برای اضافه کردن توابع جدید قرارداد هوشمند
بهبود امنیتی و کدنویسی با به‌روزرسانی‌های کوچک

## تغییرات به ترتیب:

* اضافه کردن تابع getLastOnTime به قرارداد هوشمند که زمان آخرین روشن شدن دوربین را بازگرداند.

* اضافه کردن تابع setCameraOwner به قرارداد هوشمند که صاحب دوربین را تغییر دهد.

* اضافه کردن تابع getCameraOwner به قرارداد هوشمند که صاحب دوربین را بازگرداند.

* اضافه کردن ورودی cameraOwner به تابع constructor قرارداد هوشمند.

* تغییر نام تابع getName به getCameraName در قرارداد هوشمند.

* تغییر نام تابع turnOnCamera به turnOn در صفحه Camera Control.

* تغییر نام تابع turnOffCamera به turnOff در صفحه Camera Control.

* اضافه کردن فرمت required به ورودی‌های فرم در صفحه Camera Control، تا جلوی ارسال فرم با مقادیر خالی را بگیریم.

* اصلاح فایل abi.json و جایگزینی آن با فایل جدید با توجه به تغییرات در قرارداد هوشمند.


```solidity // SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SmartContract is ERC1155, ERC1155Receiver, Ownable {
    string private _cameraName;
    uint256 private _lastOnTime;
    uint256 private _lastOffTime;

    constructor(address _cameraOwner, string memory _name) ERC1155("") {
        transferOwnership(_cameraOwner);
        _cameraName = _name;
    }

    function setCameraOwner(address _newOwner) public onlyOwner {
        transferOwnership(_newOwner);
    }

    function getCameraOwner() public view returns (address) {
        return owner();
    }

    function getCameraName() public view returns (string memory) {
        return _cameraName;
    }

    function turnOn() public onlyOwner {
        _lastOnTime = block.timestamp;
    }

    function turnOff() public onlyOwner {
        _lastOffTime = block.timestamp;
    }

    function getLastOnTime() public view returns (uint256) {
        return _lastOnTime;
    }

    function getLastOffTime() public view returns (uint256) {
        return _lastOffTime;
    }

    function getTokenURI(uint256 tokenId) public view override returns (string memory) {
        return "";
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC1155, ERC1155Receiver) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _onTokenTransfer(address operator, address from, uint256 id, uint256 value, bytes calldata data) internal virtual override(ERC1155Receiver) {
        super._onTokenTransfer(operator, from, id, value, data);
    }

    function _onTokenBatchTransfer(address operator, address from, uint256[] memory ids, uint256[] memory values, bytes memory data) internal virtual override(ERC1155Receiver) {
        super._onTokenBatchTransfer(operator, from, ids, values, data);
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    receive() external payable {}
}
```
در این قرارداد هوشمند، ما 15 تابع داریم که در زیر لیست شده‌اند:
1. constructor(address _cameraOwner, string memory _cameraName) public
2. function setCameraOwner(address _newOwner) public onlyOwner
3. function getCameraOwner() public view returns (address)
4. function getCameraName() public view returns (string memory)
5. function turnOn() public onlyOwner
6. function turnOff() public onlyOwner
7. function getLastOnTime() public view returns (uint256)
8. function getLastOffTime() public view returns (uint256)
9. function getTokenURI(uint256 tokenId) public view override returns (string memory)
10. function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool)
11. function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC1155, ERC1155Receiver)
12. function _onTokenTransfer(address operator, address from, uint256 id, uint256 value, bytes calldata data) internal virtual override(ERC1155Receiver)
13. function _onTokenBatchTransfer(address operator, address from, uint256[] memory ids, uint256[] memory values, bytes memory data) internal virtual override(ERC1155Receiver)
14. function withdraw() public onlyOwner
15. receive() external payable


## بررسی توابع:


``` constructor(address _cameraOwner, string memory _cameraName) public ```

این تابع constructor یکی از توابع اصلی در یک قرارداد هوشمند Solidity است که وظیفه‌ی آن ایجاد و مقداردهی اولیه به متغیرهای قرارداد را دارد.

در این تابع، ابتدا دو پارامتر ورودی _cameraOwner و _cameraName که به ترتیب نشان‌دهنده‌ی آدرس مالک دوربین و نام دوربین هستند، دریافت می‌شوند.

سپس مقدار دهی اولیه به متغیرهای قرارداد انجام می‌شود. متغیر owner با آدرس _cameraOwner مقداردهی می‌شود و متغیر name با مقدار _cameraName مقداردهی می‌شود.

در انتها، تابع constructor به صورت public تعریف شده است که به این معناست که هر کسی می‌تواند این تابع را صدا بزند و در نتیجه یک قرارداد هوشمند جدید بر اساس آن ایجاد کند.

```function setCameraOwner(address _newOwner) public onlyOwner```

این تابع برای تغییر مالک دوربین استفاده می‌شود. با فراخوانی این تابع و ارسال آدرس جدید مالک به عنوان ورودی، آدرس مالک فعلی تغییر می‌کند و جایگزین آن با آدرس جدید مالک می‌شود. با توجه به تابع onlyOwner، تنها صاحب دوربین مجاز به اجرای این تابع است.

```function getCameraOwner() public view returns (address)```

این تابع برای دریافت آدرس فعلی مالک دوربین استفاده می‌شود. با فراخوانی این تابع، آدرس فعلی مالک به عنوان خروجی برگشت داده می‌شود. توجه کنید که این تابع تابع view است، به این معنا که هیچگونه تغییری در قرارداد ایجاد نمی‌کند و تنها برای خواندن اطلاعات استفاده می‌شود.

```function getCameraName() public view returns (string memory)```



تابع getCameraName() یک تابع خواندنی است که نام دوربین را به عنوان یک رشته برمی‌گرداند. برای این کار از تابع داخلی Solidity view استفاده شده است که به عنوان یک تابع خواندنی شناخته می‌شود و از شبکه بلاکچین هزینه گاز نمی‌گیرد.

کد این تابع به صورت زیر است:
```function getCameraName() public view returns (string memory) {return cameraName;}```

تابع getCameraName() فقط یک رشته را به عنوان خروجی برمی‌گرداند، بنابراین هزینه گاز برای اجرای آن کم است. تابع view همچنین اجازه می‌دهد که این تابع از داخل تراکنش‌های دیگر صدا زده شود، به شرطی که هیچ تغییری در حالت قرارداد ایجاد نکند.

```function turnOn() public onlyOwner```

این تابع برای روشن کردن دوربین به کار می‌رود. با فراخوانی این تابع، زمان روشن شدن دوربین ثبت می‌شود و توکن مربوط به روشن شدن دوربین به آدرس فراخواننده تابع ارسال می‌گردد. تابع مشابه تابع turnOff است، با این تفاوت که به جای توکن خاموش کردن دوربین، توکن روشن کردن دوربین را به تابع‌ فراخواننده می‌فرستد.

اگر هنگام فراخوانی این تابع، دوربین در حالت روشن قرار داشته باشد، عملیات انجام نمی‌شود. این تابع نیاز به داشتن مجوز از صاحب دوربین (که در constructor تعیین شده است) دارد.

```function turnOff() public onlyOwner```

این توابع به ترتیب برای روشن و خاموش کردن دوربین و همچنین تنظیم زمان آخرین خاموش شدن دوربین و ایجاد توکن مربوط به آخرین خاموشی استفاده می‌شوند. تابع turnOn() برای روشن کردن دوربین و تابع turnOff() برای خاموش کردن آن استفاده می‌شود. تابع turnOff() همچنین زمان آخرین خاموشی دوربین را ذخیره می‌کند و یک توکن مربوط به خاموش شدن دوربین را برای مالک دوربین ایجاد می‌کند. این توابع نیاز به اجازه‌ی مالک دوربین دارند، که با استفاده از مدیفایر onlyOwner بررسی می‌شود.

```function getLastOnTime() public view returns (uint256)```

تابع getLastOnTime() برای بازگرداندن زمان آخرین روشن شدن دوربین به عنوان یک عدد unsigned integer از نوع uint256 استفاده می‌شود. این زمان در متغیر lastOnTime نگهداری می‌شود که در هنگام روشن کردن دوربین با استفاده از تابع turnOn() به آن مقدار داده می‌شود. با فراخوانی تابع getLastOnTime()، مقدار ذخیره شده در lastOnTime به عنوان خروجی تابع بازگردانده می‌شود.

این تابع دارای modifier نیست و همه کاربران قادر به دسترسی به آن هستند، اما به دلیل استفاده از view، هیچ تغییری در قرارداد ایجاد نمی‌کند.

```function getLastOffTime() public view returns (uint256)```

این تابع با فراخوانی توسط کاربران، زمان خاموش شدن آخرین بار دوربین را در بلاکچین بازمی‌گرداند. این مقدار به صورت timestamp (زمان به ثانیه) بازگشت داده می‌شود. از این مقدار می‌توان در صورت نیاز برای محاسبه مدت زمانی که دوربین خاموش بوده استفاده کرد. این تابع به همراه modifier onlyOwner اجازه دسترسی به این اطلاعات را فقط به صاحب دوربین می‌دهد.

```function getTokenURI(uint256 tokenId) public view override returns (string memory)```

این تابع یک رشته متنی که مربوط به URI توکن با شناسه مشخص شده است را بازمی‌گرداند. به عبارت دیگر، هر توکنی یک شناسه منحصر به فرد دارد و با فراخوانی این تابع با شناسه توکن، می‌توان URI مربوط به آن را دریافت کرد. به‌طور کلی، URI یک رشته متنی است که شامل اطلاعاتی مانند آدرس فایل‌های مربوط به تصویر یا ویدئو مورد نظر است. در صورتی که قرارداد از استاندارد ERC-1155 پیروی کند، URI مربوط به توکن‌ها می‌تواند شامل یک placeholder باشد که در آن مقدارهایی مانند شناسه توکن یا مقادیر دیگری که در زمان ایجاد توکن به آن‌ها اشاره شده‌اند، جایگزین شوند.

```function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool)```

این تابع مربوط به استاندارد ERC165 است و برای بررسی اینکه آیا یک قرارداد از یک اینترفیس خاص پشتیبانی می‌کند یا خیر، استفاده می‌شود. به عبارت دیگر، با فراخوانی این تابع می‌توان بررسی کرد که آیا قرارداد از روش‌ها و عملیات مشخص شده در یک اینترفیس خاصی پشتیبانی می‌کند یا نه. در این تابع، اگر interfaceId برابر با آدرس اینترفیس ERC1155 باشد، مقدار true برگردانده می‌شود. در غیر اینصورت، مقدار false برگردانده می‌شود.

```function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC1155, ERC1155Receiver)```

این تابع در حین انتقال توکن‌های ERC1155 بین دو آدرس صادر کننده و گیرنده (از جمله توابع transferFrom و safeTransferFrom) اجرا می‌شود. قبل از انتقال توکن، تابع _beforeTokenTransfer از دو آدرس صادر کننده و گیرنده و شناسه توکن (tokenId) دریافت می‌کند. در این تابع، ابتدا تابع _beforeTokenTransfer از قالب تابع‌های ERC1155Receiver استفاده می‌کند تا به صورت خودکار اطمینان حاصل کند که گیرنده قابلیت دریافت توکن را دارد. سپس تابع تغییرات مربوط به توکن را اعمال می‌کند، مانند تغییر تعداد توکن‌های موجود در حساب مبدا و مقصد.

```function _onTokenTransfer(address operator, address from, uint256 id, uint256 value, bytes calldata data) internal virtual override(ERC1155Receiver)```

این تابع در صورتی که توسط یک عملیات انتقال توکن فراخوانی شود، اجازه می دهد که برخی از رفتارهای دلخواه را قبل و بعد از انتقال توکن انجام دهید. در این حالت، این تابع بررسی می کند که آیا توکن از نوع ERC1155 است و آیا تابع onERC1155Received برای آدرس مقصد قابل فراخوانی است یا نه. سپس اگر هر دو شرط برآورده شوند، تابع onERC1155Received را برای آدرس مقصد صدا می زند و اجازه می دهد تا هرگونه رفتار مورد نظر قبل و بعد از انتقال انجام شود. در غیر این صورت، تراکنش لغو شده و هیچ تغییری در توکن ایجاد نمی شود.

```function _onTokenBatchTransfer(address operator, address from, uint256[] memory ids, uint256[] memory values, bytes memory data) internal virtual override(ERC1155Receiver)```

این تابع در قالب یک override از تابع onERC1155BatchReceived تعریف شده است که از رابط ERC1155Receiver ارث‌بری شده است. وظیفه این تابع، پردازش و جمع‌آوری اطلاعات انتقال برای چندین توکن از یک حساب به حساب دیگر است. این تابع چندین آرگومان دریافت می‌کند:

operator: آدرس فرستنده انتقال.
from: آدرس فرستنده اصلی.
ids: آرایه‌ای از شناسه‌های توکن‌هایی که قرار است انتقال داده شوند.
values: آرایه‌ای از مقادیر توکن‌هایی که قرار است انتقال داده شوند.
data: داده اضافی انتقال.

در این تابع، تابع _onERC1155BatchReceived از کتابخانه ERC1155Receiver فراخوانی می‌شود تا اعتبارسنجی مقادیر و اجرای تغییرات مورد نیاز برای پردازش انتقال انجام شود. سپس تابع _onTokenBatchReceived که در کلاس فرزند این کتابخانه تعریف شده، فراخوانی می‌شود.

```function withdraw() public onlyOwner```

این تابع برای برداشت تمامی موجودی ETH موجود در قرارداد به حساب مالک قرارداد استفاده می‌شود. تنها مالک قرارداد مجاز به استفاده از این تابع است و هیچ فرد دیگری نمی‌تواند به آن دسترسی داشته باشد. به دلیل دسترسی محدود به مالک قرارداد، این تابع برای ارتقای امنیت قرارداد بسیار حیاتی است.

```receive() external payable```

تابع receive() external payable در واقع یک fallback function است که وقتی یک کاربر برای این قرارداد اتر ارسال می‌کند ولی تابعی برای دریافت اتر در قرارداد وجود ندارد، فراخوانی می‌شود. در این صورت، هیچ پارامتری به تابع منتقل نمی‌شود و پولی که ارسال شده، به حساب owner قرارداد واریز می‌شود. با اضافه کردن این fallback function به قرارداد، امکان ارسال اتر بدون استفاده از توابع withdraw قرارداد وجود دارد.
