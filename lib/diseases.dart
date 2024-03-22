class Disease{
  final int id;
  final String title, description;
  final String imge;

 Disease(    {required this.id, required this.title,required this.description,required this.imge,});
}
List<Disease> diseases  =[
 Disease(
  id: 1,
  title: 'Melanoma',
  description: '-Melanoma, the most serious type of skin cancer, develops in the cells (melanocytes) that '
  'produce melanin — the pigment that gives your skin its color. Melanoma can also form in your eyes and, rarely, inside your body, such as in your nose or throat.'
  'The risk of melanoma seems to be increasing in people under 40, especially women. Knowing the warning signs of skin cancer can help ensure that cancerous changes are detected and treated before the cancer has spread. Melanoma can be treated successfully if it is detected early.'
  '                            '
  '                             '
    '                             '

  '-The first sign of melanoma is often a mole that changes size, shape or color. This melanoma shows color variations and an irregular border, both of which are melanoma warning signs.'
  ,imge: 'lib/counter/Melanoma.jpg'
 ),
 Disease(
  id: 2, 
  title: '\nMelanocytic nevus',
 description: 'Giant congenital melanocytic nevus is a skin condition characterized by an abnormally dark, noncancerous skin patch (nevus) that is composed of pigment-producing cells called melanocytes. It is present from birth (congenital) or is noticeable soon after birth.'
   ,imge: 'lib/counter/Melanocytic_nevus.jpg'

 ),



 Disease(
  id: 3,
   title: 'Basal cell \ncarcinoma',
    description: 'Basal cell carcinoma occurs most often on areas of the skin that are exposed to the sun, such as your head and neck.'
    "                    "
    "                     "
    'Most basal cell carcinomas are thought to be caused by long-term exposure to ultraviolet (UV) radiation from sunlight. Avoiding the sun and using sunscreen may help protect against basal cell carcinoma.'
      ,imge: 'lib/counter/basal-cell-carcinoma.jpg'

    ),

Disease(
  id: 4,
   title: 'Actinic keratosis',
    description: '(also called solar keratoses)  '
    "                    "
    "                     "
    'are dry scaly patches of skin that have been damaged by the sun. The patches are not usually serious. But theres a small chance they could become skin cancer, so its important to avoid further damage to your skin.'
      ,imge: 'lib/counter/Actinic_keratosis.jpg'

    ),

Disease(
  id: 5,
   title: '\nDermatofibroma',
    description: 'Dermatofibromas are harmless growths within the skin that usually have a small diameter. '
     "                    "
    "                     "
    'They can vary in color but are typically pink to light brown in light skin and dark brown or black in dark skin. They may appear more pink or darker if a person accidentally irritates them — for example, when shaving.'
      ,imge: 'lib/counter/Dermatofibroma.jpg'

    ),
 
 
Disease(
  id: 6,
   title: 'Vascular lesion',
    description: 'Vascular lesions are relatively common abnormalities of the skin and underlying tissues, more commonly known as birthmarks.'
      ,imge: 'lib/counter/VASCULAR-LESIONS.jpg'

    ),


Disease(
  id: 7,
   title: 'Squamous cell carcinoma',
    description: 'Squamous cell carcinoma of the skin is a common form of skin cancer that develops in the squamous cells that make up the middle and outer layers of the skin. Squamous cell carcinoma of the skin is usually not life-threatening, though it can be aggressive'
      ,imge: 'lib/counter/squamous-cell-carcinoma.jpg'

    ),    
];
