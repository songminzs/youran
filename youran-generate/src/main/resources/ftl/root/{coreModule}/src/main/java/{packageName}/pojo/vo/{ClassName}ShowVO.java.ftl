<#include "/common.ftl">
<#--定义主体代码-->
<#assign code>
<@call this.addImport("io.swagger.annotations.ApiModel")/>
<@call this.addImport("io.swagger.annotations.ApiModelProperty")/>
<@call this.addImport("${this.commonPackage}.pojo.vo.AbstractVO")/>
<@call this.addStaticImport("${this.packageName}.pojo.example.${this.classNameUpper}Example.*")/>
<@call this.printClassCom("【${this.title}】详情展示对象")/>
@ApiModel(description = "【${this.title}】详情展示对象")
public class ${this.classNameUpper}ShowVO extends AbstractVO {

<#list this.showFields as field>
    @ApiModelProperty(notes = N_${field.jfieldName?upperCase},example = E_${field.jfieldName?upperCase})
    <#if field.jfieldType==JFieldType.DATE.getJavaType()>
        <@call this.addImport("java.util.Date")/>
        <@call this.addImport("com.fasterxml.jackson.annotation.JsonFormat")/>
        <@call this.addImport("${this.commonPackage}.constant.JsonFieldConst")/>
    @JsonFormat(pattern=JsonFieldConst.DEFAULT_DATETIME_FORMAT,timezone="GMT+8")
    <#elseIf field.jfieldType==JFieldType.BIGDECIMAL.getJavaType()>
        <@call this.addImport("java.math.BigDecimal")/>
    </#if>
    private ${field.jfieldType} ${field.jfieldName};

</#list>
<#list this.fields as field>
    <#if field.cascadeShowExts?? && field.cascadeShowExts?size &gt; 0>
        <#list field.cascadeShowExts as cascadeExt>
            <#assign cascadeField=cascadeExt.cascadeField>
            <#assign examplePackage="">
            <#if field.foreignEntity!=this.metaEntity>
                <#assign examplePackage="${this.packageName}.pojo.example.${field.foreignEntity.className?capFirst}Example.">
            </#if>
    @ApiModelProperty(notes = ${examplePackage}N_${cascadeField.jfieldName?upperCase},example = ${examplePackage}E_${cascadeField.jfieldName?upperCase})
            <#if cascadeField.jfieldType==JFieldType.DATE.getJavaType()>
                <@call this.addImport("java.util.Date")/>
                <@call this.addImport("com.fasterxml.jackson.annotation.JsonFormat")/>
                <@call this.addImport("${this.commonPackage}.constant.JsonFieldConst")/>
    @JsonFormat(pattern=JsonFieldConst.DEFAULT_DATETIME_FORMAT,timezone="GMT+8")
            <#elseIf cascadeField.jfieldType==JFieldType.BIGDECIMAL.getJavaType()>
                <@call this.addImport("java.math.BigDecimal")/>
            </#if>
    private ${cascadeField.jfieldType} ${cascadeExt.alias};

        </#list>
    </#if>
</#list>
<#if this.metaEntity.mtmHoldRefers??>
    <#list this.metaEntity.mtmHoldRefers as otherEntity>
        <@call this.addImport("java.util.List")/>
        <#assign otherCName=otherEntity.className/>
        <#assign othercName=otherEntity.className?uncapFirst>
        <#assign otherType=otherEntity.pkField.jfieldType>
        <#assign otherPkId=MetadataUtil.getPkAlias(othercName,false)>
    @ApiModelProperty(notes = "【${otherEntity.title}】列表")
    private List<${otherCName}ListVO> ${othercName}List;

    </#list>
</#if>

<#list this.showFields as field>
    <@call TemplateUtil.printGetterSetter(field)/>
</#list>
<#list this.fields as field>
    <#if field.cascadeShowExts?? && field.cascadeShowExts?size &gt; 0>
        <#list field.cascadeShowExts as cascadeExt>
            <@call TemplateUtil.printGetterSetter2(cascadeExt.alias cascadeExt.cascadeField.jfieldType)/>
        </#list>
    </#if>
</#list>
<#if this.metaEntity.mtmHoldRefers??>
    <#list this.metaEntity.mtmHoldRefers as otherEntity>
        <#assign otherCName=otherEntity.className/>
        <#assign othercName=otherEntity.className?uncapFirst>
        <@call TemplateUtil.printGetterSetterList(othercName "${otherCName}ListVO")/>
    </#list>
</#if>

}
</#assign>
<#--开始渲染代码-->
package ${this.packageName}.pojo.vo;

<@call this.printImport()/>

${code}
