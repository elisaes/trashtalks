// const typesContainer = document.querySelector(".TypesContainer")

// Initialise 
let typeData = []

// get all necessary DOM components
const typesContainer = document.getElementsByClassName("TypesContainer")
const createListBtn = document.getElementById("submitBtn")

// get all the data from the divs, if the form is empty, the array will be empty as well
$('.TypesContainer').each(function(){
    typeData.push(($(this).data('types')))
});

const addItemButton = document.querySelector("#addItemToList");
let listItemIdx = 0;

const materials = ["Metal","Glass","Plastic","Paper","Cardboard"]


const generateDomElement = (type, className = null) => {

    const element = document.createElement(type);

    if (className) {
        element.className = className;
    }

    return element;
}

// event handler for RemoveBtn
let removeContainer = (e) => { 
    // prevent the form from being submitted
    e.preventDefault(); 
    let tyContainer = e.target.parentNode

    // if the current form is new
    if (typesContainer.length > 1 && typeData.length === 0)
        tyContainer.parentNode.remove()
    // if the current form is edit
    else if (typesContainer.length > 1 && typeData.length > 0) 
        tyContainer.remove()
}

const generateTypeInputForm = (index, container) => {

    // create wrapper container
    const typeInputContainerEl = generateDomElement("div","TypeInputContainer");

    // create material inputs
    const materialInputContainerEl = generateDomElement("div", "MaterialInputs");

    for (const material of materials) {
        const inputEl = generateDomElement("input")
        inputEl.type = "radio"
        inputEl.value = `${material}`
        inputEl.name = `list[types_attributes][${index}][material]`
        
        materialInputContainerEl.appendChild(inputEl);

        const labelEl = generateDomElement("label");
        labelEl.innerText = material;

        materialInputContainerEl.appendChild(labelEl);
    
    }


    // we check the radio button accordingly
    let checkedButton = 0

    // if this is edit form, get the data and reference the correct button
    if (typeData[index] !== undefined) 
        checkedButton = materials.indexOf(typeData[index].material)
    
    // using an if/else, skip the labels and update the radio buttons instead
    if (checkedButton === 1)
        materialInputContainerEl.childNodes[2].checked = true 
    else if (checkedButton === 2) 
        materialInputContainerEl.childNodes[4].checked = true
    else // default of metal or index = 0
        materialInputContainerEl.childNodes[0].checked = true 


    typeInputContainerEl.appendChild(materialInputContainerEl);

    // create remarks input
    const remarkContainerEl = generateDomElement("div","RemarksInput")

    const remarksLabelEl = generateDomElement("label");
    remarksLabelEl.innerText = "Remarks"

    remarkContainerEl.appendChild(remarksLabelEl);

    const remarkInputEl = generateDomElement("input");

    // we update the remarks accordingly
    remarkInputEl.value = typeData[index] != undefined ? typeData[index].remarks : ""

    remarkInputEl.type = "text"
    remarkInputEl.name = `list[types_attributes][${index}][remarks]`

    remarkContainerEl.appendChild(remarkInputEl);

    materialInputContainerEl.appendChild(remarkContainerEl)
    
    // create weight input
    const weightContainerEl = generateDomElement("div","WeightInput")

    const weightLabelEl = generateDomElement("label");
    weightLabelEl.innerText = "Weight(KG)"

    weightContainerEl.appendChild(weightLabelEl);

    const weightInputEl = generateDomElement("input");
    weightInputEl.type = "number"
    weightInputEl.name = `list[types_attributes][${index}][weight]`
    weightInputEl.step = "0.1"
    weightInputEl.min="0.1"
    weightInputEl.max="10"

    // we update the weight accordingly
    weightInputEl.value = typeData[index] != undefined ? typeData[index].weight : 0
    
    weightContainerEl.appendChild(weightInputEl);

    // Adding remove button
    const removeBtn = generateDomElement("button")
    removeBtn.classList.add("btn");
    removeBtn.classList.add("btn-outline-danger");
    removeBtn.classList.add("mb-2");
    removeBtn.textContent = "Remove"
    removeBtn.addEventListener('click', removeContainer)
    // end remove button

    materialInputContainerEl.appendChild(weightContainerEl);
    typeInputContainerEl.appendChild(removeBtn)
    
    container.appendChild(typeInputContainerEl)
    // we will insert this container before submitBtn
    document.querySelector("form").insertBefore(container, submitBtn)
}

addItemButton.addEventListener("click", (e)=>{
    e.preventDefault();
    const container = generateDomElement("div", "TypesContainer")
    generateTypeInputForm(listItemIdx++, container);
})

// new form - following runs exactly once, edit form will run for as many items as there are
for (let i = 0; i < typesContainer.length; i++) {
    generateTypeInputForm(listItemIdx++, typesContainer[i]);
}
